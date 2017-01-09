class Vloer < ActiveRecord::Base
    belongs_to :order_state
    has_many :items, dependent: :destroy
    has_many :regels
    has_many :calculations, dependent: :destroy
    accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :calculations, reject_if: :all_blank, allow_destroy: true
    
    validates :organisatie, presence: true
    validates :datum, presence: true
    validates :werkbon_type, presence: true
    validates :werkvoorbereider, presence: true
end
