class Vloer < ActiveRecord::Base
    belongs_to :order
    has_many :items
    has_many :regels
    has_many :calculations
    accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :calculations, reject_if: :all_blank, allow_destroy: true
    
    validates :organisatie, presence: true
    validates :datum, presence: true
    validates :werkbon_type, presence: true
    validates :werkvoorbereider, presence: true
end
