module Mutations
  module Pokemons
    class AppearInTheWild < BaseMutation
      type Types::Pokemons::Events::WildAppear, null: false
      
      def resolve(**params)
        result = wild_appearance

        result.success? ? result.event : { error: result.error }
      end

      private

      def wild_appearance
        ::Pokemons::WildAppearance.call
      end
    end
  end
end