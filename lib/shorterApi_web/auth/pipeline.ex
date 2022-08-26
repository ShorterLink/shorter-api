defmodule ShorterApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :shorterApi

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
