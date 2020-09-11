defmodule Campfire.Api do
  use Ash.Api,
  extensions: [
    AshGraphql.Api
  ]

  graphql do
    authorize? true
  end

  resources do
    resource Campfire.Accounts.User
    resource Campfire.Messages.Message
  end
end
