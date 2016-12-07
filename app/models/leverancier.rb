class Leverancier < ActiveRecord::Base
    has_many :leverancier_regels
    has_many :regels
    accepts_nested_attributes_for :leverancier_regels, reject_if: :all_blank, allow_destroy: true
    
    validates :leverancier_label, presence: true, uniqueness: true
    validates :leverancier_werkbon, presence: true
end
