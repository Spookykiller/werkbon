class Vloer < ActiveRecord::Base
    has_many :items
    has_many :regels
    has_many :calculations
    accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :calculations, reject_if: :all_blank, allow_destroy: true
    
    filterrific(
      available_filters: [
        :naam
      ]
    )
end
