class Order < ActiveRecord::Base
    has_many :order_states, dependent: :destroy
    
    validates :project_naam, presence: true
    validates :project_nummer, presence: true
    validates :inmeetdatum, presence: true
    validates :oplevering, presence: true
    validates :email, presence: true
    validates :contactpersoon, presence: true
    
    def self.search(query)
      where("LOWER(project_naam) like ?", "%#{query}%") 
    end
end
