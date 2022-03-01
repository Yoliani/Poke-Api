class Api::Pokemon::PokemonController < ApplicationController
  @all_pokemons_validate = 0
  def index
    # require 'pry'; binding.pry
    if params['query'] != '' and !params['query'].nil? and Pokedex.count != 0
      query(params[:query])
    elsif params['limit'] == '' or params['limit'].to_i > 0 and Pokedex.count != 0
      limit = if params['limit'].to_i > 0
                params['limit'].to_i
              else
                10
              end
      show_limit(limit)
    elsif !params.has_key?(:query) or !params.has_key?(:limit)

      response = HTTParty.get('https://pokeapi.co/api/v2/pokemon?limit=150')
      @pokemons = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry
      create(@pokemons) if Pokedex.count.zero?
      @pokemons = Pokedex.all
      @pokemons = delete_keys(@pokemons)
      render json: @pokemons
    else
      render json: { error: 'No hay pokemones' }
    end
  end

  def create(json)
    json[:results].each do |result|
      response_pokemon = HTTParty.get(result[:url])

      json_pokemon = JSON.parse(response_pokemon.body, symbolize_names: true)
      array_types = []
      json_pokemon[:types].each do |type|
        array_types.push(type[:type][:name].capitalize)
      end
      hash_types = []
      json_pokemon[:stats].each do |stat|
        hash_types.push({ 'name' => stat[:stat][:name], 'base_stat' => stat[:base_stat],
                          'effort' => stat[:effort] })
      end
      # next if Pokedex.find_by(id: json_pokemon[:id])

      poke = Pokedex.create(id_pokemon: json_pokemon[:id]  , name:  json_pokemon[:name],
                            description: 'Raises the likelihood of meeting wild Pokémon', types: array_types,
                            image_url: json_pokemon[:sprites][:other][:dream_world][:front_default])

      json_pokemon[:stats].each do |stat|
        poke.poke_stat.create(name: stat[:stat][:name],
                              base_stat: stat[:base_stat], effort: stat[:effort])
        # require 'pry'
        # binding.pry
      end

      # require 'pry'; binding.pry
    end
  end

  def show_limit(limit)
    @pokemons = Pokedex.limit(limit)
    @pokemons = delete_keys(@pokemons)
    render json: @pokemons
  end

  def show_one
    prueba = Pokedex.find_by(name: params[:id])
    prueba = delete_key(prueba)
    if prueba
      render json: prueba
    elsif Pokedex.find_by(id_pokemon: params[:id])
      prueba = Pokedex.find_by(id: params[:id])
      prueba = delete_key(prueba)
      render json: prueba
    end
  end

  def query(query_params)
    # query = Pokedex.that_sounds_like(query_params)
    query_find = Pokedex.where('name LIKE ?', '%' << query_params << '%')

    json = query_find
    query_find = delete_keys(json)
    # require 'pry';binding.pry

    # query_find = Pokedex.roughly_spelled_like(query_params)
    # require 'pry'
    # binding.pry
    render json: query_find
  end

  def delete_keys(json)
    json = JSON.parse(json.to_json)
    json.each do |json_poke|
      json_poke.delete('id_pokemon')
      json_poke['poke_stat'].each do |stat_p|
        # require 'pry'
        # binding.pry
        stat_p.delete('id')
        stat_p.delete('pokedex_id')
      end
    end
    json
  end

  def delete_key(json)
    json_poke = JSON.parse(json.to_json)
    require 'pry'
    binding.pry
     json_poke.delete('id_pokemon')
    json_poke['poke_stat'].each do |stat_p|
      stat_p.delete('id')
      stat_p.delete('pokedex_id')
    end

    json
  end
end
