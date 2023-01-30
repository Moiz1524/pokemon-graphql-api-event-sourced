module Pokemons
  class WildAppearance < BaseInteractor
    def call
      prepare_id_and_stream
      instantiate_aggregate_repository
      pokemon.appear_in_the_wild(pokemon_id: pokemon_id, route: '11')
      capture_associated_event
    rescue => e
      context.fail!(error: e.message)
    end

    private

    def prepare_id_and_stream
      # Grab a random pokemon_id
      @pokemon_id = SecureRandom.uuid
      # Prepare unique stream_name
      @stream_name = "Pokemon$#{@pokemon_id}"
    end

    def instantiate_aggregate_repository
       # Instantiate a new aggregate repository
       @repository = AggregateRoot::Repository.new

       # Instantiate a new pokemon aggregate instance and load into repository
       @pokemon = @repository.load(Aggregates::Pokemon.new(@pokemon_id), @stream_name)
       # Fire #appear_in_the_wild method to capture associated event
    end

    def capture_associated_event
      # Store event into repository
      @repository.store(@pokemon, @stream_name)
    end
  end
end