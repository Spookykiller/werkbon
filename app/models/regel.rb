class Regel < ActiveRecord::Base
    has_many :dropdowns
    has_many :second_dropdowns
    belongs_to :vloer
    belongs_to :leverancier
    
    accepts_nested_attributes_for :dropdowns, reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :second_dropdowns, reject_if: :all_blank, allow_destroy: true
    
    validates :werkbon, presence: true
    validates :label, presence: true, uniqueness: true
end
