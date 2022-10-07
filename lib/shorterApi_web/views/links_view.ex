defmodule ShorterApiWeb.LinksView do
  use ShorterApiWeb, :view
  alias ShorterApi.Link

  def render("create.json", %{
        link: %Link{
          id: id,
          name: name,
          hash: hash,
          clicks: clicks,
          url: url,
          inserted_at: inserted_at,
          updated_at: updated_at
        }
      }) do
    %{
      message: "Link created!",
      link: %{
        id: id,
        name: name,
        hash: hash,
        clicks: clicks,
        url: url,
        inserted_at: inserted_at,
        updated_at: updated_at
      }
    }
  end

  def render("update.json", %{
        link: %Link{
          id: id,
          name: name,
          hash: hash,
          clicks: clicks,
          enabled: enabled,
          url: url,
          inserted_at: inserted_at,
          updated_at: updated_at
        }
      }) do
    %{
      message: "Link updated!",
      link: %{
        id: id,
        name: name,
        hash: hash,
        clicks: clicks,
        enabled: enabled,
        url: url,
        inserted_at: inserted_at,
        updated_at: updated_at
      }
    }
  end

  def render("show.json", %{
        link: %Link{
          id: id,
          name: name,
          hash: hash,
          clicks: clicks,
          enabled: enabled,
          url: url,
          inserted_at: inserted_at,
          updated_at: updated_at
        }
      }) do
    %{
      id: id,
      name: name,
      hash: hash,
      clicks: clicks,
      url: url,
      enabled: enabled,
      inserted_at: inserted_at,
      updated_at: updated_at
    }
  end

  def render(
        "show_all.json",
        %{link: link}
      ) do
    %{
      data: render_many(link, ShorterApiWeb.LinksView, "link.json"),
      page_number: link.page_number,
      page_size: link.page_size,
      total_pages: link.total_pages,
      total_entries: link.total_entries
    }
  end

  def render("link.json", %{links: link}) do
    {:ok, front_base_url} = Application.fetch_env(:shorterApi, :front_base_url)

    %{
      id: link.id,
      name: link.name,
      hash_url: "#{front_base_url}/#{link.hash}",
      clicks: link.clicks,
      url: link.url,
      enabled: link.enabled,
      inserted_at: link.inserted_at,
      updated_at: link.updated_at
    }
  end
end
