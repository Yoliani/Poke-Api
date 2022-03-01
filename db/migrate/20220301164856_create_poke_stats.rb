class CreatePokeStats < ActiveRecord::Migration[7.0]
  def change
    create_table :poke_stats do |t|
      t.string :name
      t.integer :base_stat
      t.integer :effort

      t.belongs_to :pokedex
    end
  end
end
