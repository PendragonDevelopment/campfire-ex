defmodule Campfire.Accounts.User do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [
      AshGraphql.Resource
    ]

  postgres do
    table "users"
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

    attribute :first_name, :string do
      constraints min_length: 1
    end

    attribute :last_name, :string do
      constraints min_length: 1
    end

    attribute :email, :string, allow_nil?: false, constraints: [
      match: ~r/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}/
    ]

    attribute :admin, :boolean do
      allow_nil? false
      default false
    end
  end

  graphql do
    type :user

    fields @fields

    queries do
      get :get_user, :read
      list :list_users, :read
    end

    mutations do
      create :create_user, :create
      update :update_user, :update
      destroy :destroy_user, :destroy
    end
  end

  validations do
    validate present([:email], exactly: 1)
  end

  relationships do
    has_many :sent_messages, Campfire.Messages.Message do
      destination_field :sender_id
    end

    has_many :received_messages, Campfire.Messages.Message do
      destination_field :recipient_id
    end
  end
end
