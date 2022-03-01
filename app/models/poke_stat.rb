class PokeStat < ApplicationRecord
  belongs_to :pokedex
  def self.all
    find(:all)
  end
end
