class OrderStatesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_order, only: [:index, :show]
    before_action :find_order_state, only: [:show]
    
    def index
        @fase_veld = "Volgende fase"
        @order_states = OrderState.where(:order_id => @order).order("status ASC")
        
        @offerte_werkbonnen = Vloer.where(:order_state_id => @order.order_states.first)
        @meting_werkbonnen = Vloer.where(:order_state_id => @order.order_states.second)
        @definitieve_werkbonnen = Vloer.where(:order_state_id => @order.order_states.last)
        
        if current_user.role == 0
            @fase_veld = "Volgende fase"
        elsif current_user.role == 1
            @fase_veld = "Klaar voor meting/akkoord"
        elsif current_user.role == 2
            @fase_veld = "Ingemeten"
        elsif current_user.role == 3
            @fase_veld = "Gereed voor bestellen"
        elsif current_user.role == 4
            @fase_veld = "Besteld"
        elsif current_user.role == 5
            @fase_veld = "Eindstaat bereikt"
        end
        
    end
    
    def show
        @vloers = Vloer.where(:order_state_id => @order_state)
    end
    
    private
    
    def order_state_params
        params.require(:order_state).permit(:status, :order_id)
    end
    
    def find_order
        @order = Order.find(params[:order_id])
    end
    
    def find_order_state
        @order_state = OrderState.find(params[:order_state_id])
    end
end
