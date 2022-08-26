defmodule ShorterApi do
  alias ShorterApi.{User, Link}

  defdelegate create_user(params), to: User.Create, as: :call
  defdelegate delete_user(params), to: User.Delete, as: :call
  defdelegate fetch_user(params), to: User.Get, as: :call
  defdelegate update_user(params), to: User.Update, as: :call

  defdelegate create_link(params), to: Link.Create, as: :call
  defdelegate fetch_link(params), to: Link.Get, as: :call
  defdelegate fetch_all_links(params), to: Link.GetAll, as: :call
  defdelegate update_link(params), to: Link.Update, as: :call
  defdelegate delete_link(params), to: Link.Delete, as: :call
end
