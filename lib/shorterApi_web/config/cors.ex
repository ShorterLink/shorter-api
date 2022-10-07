defmodule ShorterApiWeb.CORS do
  use Corsica.Router,
    origins: ["http://127.0.0.1:5173", "http://127.0.0.1"],
    allow_credentials: true,
    max_age: 600,
    allow_headers: ["authorization"]

  resource("/public/*", origins: "*")
  resource("/*")
end
