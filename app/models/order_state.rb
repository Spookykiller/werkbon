class OrderState < ActiveRecord::Base
    belongs_to :order
    has_many :vloers, dependent: :destroy
    
    validates :status, :uniqueness => {:scope => :order_id}
end
