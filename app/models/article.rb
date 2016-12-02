class Article < ActiveRecord::Base
    validates :omschrijving, uniqueness: true, presence: true
    validates :prijs, presence: true
    validates :eenheid, presence: true
end
