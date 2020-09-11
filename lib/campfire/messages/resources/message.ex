defmodule Campfire.Messages.Message do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [
      AshGraphql.Resource
    ]

  postgres do
    table "messages"
    repo Campfire.Repo
  end

  actions do
    read :read
    create :create
    update :update
    destroy :destroy
  end

  attributes do
    attribute :id, :uuid do
      primary_key? true
      default &Ecto.UUID.generate/0
    end

    attribute :subject, :string
    attribute :description, :string
    attribute :response, :string
    attribute :status, :string do
      allow_nil? false
      default "new"
    end
  end

  graphql do
    type :message

    fields @fields

    queries do
      get :get_message, :read
      list :list_messages, :read
    end

    mutations do
      create :create_message, :create
      update :update_message, :update
      destroy :destroy_message, :destroy
    end
  end

  validations do
    validate one_of(:status, ["new", "read", "archived"])
  end

  relationships do
    belongs_to :recipient, Campfire.Accounts.User
    belongs_to :sender, Campfire.Accounts.User
  end
end
