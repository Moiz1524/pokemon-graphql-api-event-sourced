module Types
  module Pokemons
    module Events
      class WildAppear < Types::BaseObject
        field :event_id, String, null: false
        field :metadata, GraphQL::Types::JSON, null: false
        field :data, GraphQL::Types::JSON, null: false
      end
    end
  end
end