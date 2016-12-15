class Article < ActiveRecord::Base
    belongs_to :regel
    
    validates :omschrijving, uniqueness: true, presence: true
    validates :prijs, presence: true
    validates :eenheid, presence: true
end
