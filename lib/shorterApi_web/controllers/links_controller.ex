defmodule ShorterApiWeb.LinksController do
  use ShorterApiWeb, :controller
  alias ShorterApi.Link

  action_fallback ShorterApiWeb.FallbackController

  def index(conn, params) do
    {:ok, user} = Guardian.Plug.current_resource(conn)

    ShorterApi.fetch_all_links(params)
    |> handle_response(conn, "show_all.json", :ok)
  end

  def create(conn, params) do
    {:ok, user} = Guardian.Plug.current_resource(conn)

    params = Map.put_new(params, "hash", Link.generate_hash())

    %{"name" => name, "hash" => hash, "url" => url} = params

    %{
      name: name,
      url: url,
      hash: hash,
      clicks: 0,
      users_id: user.id,
      enabled: true
    }
    |> ShorterApi.create_link()
    |> handle_response(conn, "create.json", :created)
  end

  def update(conn, params) do
    params
    |> ShorterApi.update_link()
    |> handle_response(conn, "update.json", :ok)
  end

  def delete(conn, %{"id" => id}) do
    id
    |> ShorterApi.delete_link()
    |> handle_delete(conn)
  end

  def show(conn, %{"id" => id}) do
    id
    |> ShorterApi.fetch_link()
    |> handle_response(conn, "show.json", :ok)
  end

  def count_view(conn, %{"id" => id}) do
    IO.puts("teste")
    IO.puts(id)

    link =
      id
      |> ShorterApi.fetch_link()

    case link do
      {:error, _} -> handle_response(link, conn, "update.json", :error)
      {:ok, link} -> handle_register_new_click(link, conn)
    end
  end

  defp handle_register_new_click(link, conn) do
    if link.enabled == false do
      handle_response({:error, "Link not found or disabled"}, conn, "update.json", :error)
    else
      link =
        Map.put(%{}, "id", link.id)
        |> Map.put("clicks", link.clicks + 1)

      ShorterApi.update_link(link)
      |> handle_response(conn, "update.json", :ok)
    end
  end

  defp handle_delete({:ok, _user}, conn) do
    conn
    |> put_status(:no_content)
    |> text("")
  end

  defp handle_delete({:error, _reason} = error, _conn) do
    error
  end

  defp handle_response({:ok, link}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, link: link)
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status) do
    error
  end
end
