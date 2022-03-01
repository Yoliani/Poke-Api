class PokemonService
  def fetch()
    conn = Faraday.new('https://pokeapi.co')
    response = conn.get("/api/v2/pokemon?limit=150")
    json = JSON.parse(response)
    


    return response
  end 


  def response_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end 