class Pokedex < ApplicationRecord
  # fuzzy_search_attributes :name
  has_many :poke_stat

  include PgSearch::Model
  pg_search_scope :search_title, against: :name
  pg_search_scope :similarity_like,
                  against: :name,
                  using: {
                    trigram: {
                      word_similarity: true
                    }
                  }

  pg_search_scope :word_similarity_like,
                  against: :name,
                  using: [:trigram]
  pg_search_scope :that_sounds_like,
                  against: :name,
                  using: :dmetaphone
  pg_search_scope :kinda_spelled_like,
                  against: :name,
                  using: :trigram
  pg_search_scope :roughly_spelled_like,
                  against: :name,
                  using: {
                    trigram: {
                      threshold: 0.1
                    }
                  }
end
