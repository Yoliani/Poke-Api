class CreatePokedexes < ActiveRecord::Migration[7.0]
  def change
    create_table :pokedexes do |t|
      t.integer :id_pokemon
      t.string :name
      t.string :description
      t.string :types, array: true
      t.string :image_url

      t.timestamps
      t.has_many :poke_stat
    end
  end
end
