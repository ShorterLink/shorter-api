defmodule ShorterApi.UserTest do
  use ShorterApi.DataCase

  alias ShorterApi.User

  describe "changeset/1" do
    test "when all user params are valid, return a valid changeset" do
      params = %{name: "Tulio Test", email: "tulio@test.com", password: "iloveopensource"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               action: nil,
               changes: %{
                 email: "tulio@test.com",
                 name: "Tulio Test",
                 password: "iloveopensource"
               },
               errors: [],
               data: %ShorterApi.User{},
               valid?: true
             } = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      params = %{email: "tulio@test.com", password: "iloveopensource"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               action: nil,
               changes: %{
                 email: "tulio@test.com",
                 password: "iloveopensource"
               },
               data: %ShorterApi.User{},
               valid?: false
             } = response

      assert errors_on(response) == %{name: ["can't be blank"]}
    end
  end
end
