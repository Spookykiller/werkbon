class OrdersController < ApplicationController
    before_action :authenticate_user!
    layout 'werkbonnen'
    before_action :find_order, only: [:print, :edit, :update, :destroy]
    helper_method :filtered_orders

    def index
        @orders = filtered_orders
        
        # if params[:search]
        #     @orders = Order.search(params[:search]).order("created_at DESC")
        # else
        #     @orders = Order.order(sort_column + " " + sort_direction)
            # @orders = Order.joins(:order_states).group("orders.id").having('count(order_id) > 0')
        # end
    end
    
    def new
        @order = Order.new
    end
    
    def create
        @order = Order.new order_params

        if @order.save
            flash[:notice] = "De order is opgeslagen!"
            redirect_to action: "index"
            
            # nieuwe orderstatus van de order aanmaken en deze status intialiseren op offerte (0)
            OrderState.create(:status => 0, :order_id => @order.id)
        else
            render 'new'
            flash[:notice] = "Oh nee! De order is niet opgeslagen."
        end
    end
    
    def print
    end
    
    def edit
    end
    
    def update
        if @order.update order_params
            flash[:notice] = "De order is succesvol aangepast."
            redirect_to action: "index"
        else
            flash[:notice] = "Oh nee! De order kon niet opgeslagen worden."
            render 'edit'
        end
    end
    
    def destroy
        @order.destroy
        redirect_to action: "index"
    end
    
    private
    
    def order_params
        params.require(:order).permit(:status, :naam, :project_nummer, :project_naam, :AdressLine1, :AdressLine3, :AdressLine4, :navigatie_adres, :telefoon, :email, :contactpersoon, :inmeetdatum, :oplevering, :ordernummer, :totale_prijs, :totale_arbeid, items_attributes: [:id, :voorraad_actie, :hoeveelheid, :omschrijving, :var1, :var1_name, :var2, :var2_name, :var3, :var3_name, :var4, :var4_name, :article_prijs, :prijs, :totale_prijs, :totale_arbeid, :werkbon_type, :_destroy], calculations_attributes: [:id, :werkbon, :ruimte, :breedte, :hoogte, :stuks, :bed, :voeren, :hoofdje, :bediening, :type, :uitlijnen, :bmdm, :_destroy] )
    end
    
    def find_order
        @order = Order.find(params[:id]) 
    end
    
    def filtered_orders
        # Order.joins(:order_states).where(:order_states => { :status => 2 })
        # Order.joins(:vloers).group(:id).where(:vloers => { :status => 1, :backup => nil })
        # Order.all
        
        # when filter is on all_werkbonnen all werkbonnen get showed up
        if params[:sort] == "yet_to_processed_werkbonnen"
            if current_user.role == 0
                Order.joins(:vloers).group(:id).where(:vloers => { :status => (0 || 2), :backup => nil })
            elsif current_user.role == 1
                Order.joins(:vloers).group(:id).where(:vloers => { :status => (0 || 2), :backup => nil })
            elsif current_user.role == 2
                order_query(1, nil)
            elsif current_user.role == 3
                order_query(3, nil)
            elsif current_user.role == 4
                order_query(4, nil)
            elsif current_user.role == 5
                order_query(5, nil)
            end
        elsif params[:sort] == "backup_werkbonnen"
            if current_user.role == 0
                Order.joins(:vloers).group(:id).where(:vloers => { :status => (0 || 2), :backup => true })
            elsif current_user.role == 1
                Order.joins(:vloers).group(:id).where(:vloers => { :status => (0 || 2), :backup => true })
            elsif current_user.role == 2
                order_query(1, true)
            elsif current_user.role == 3
                order_query(3, true)
            elsif current_user.role == 4
                order_query(4, true)
            elsif current_user.role == 5
                order_query(5, true)
            end
        elsif params[:sort] == "empty_werkbonnen"
            Order.includes(:vloers).where( :vloers => { :id => nil } )
        else 
            Order.all.order('inmeetdatum ASC')
        end
    end
    
    def order_query(status, backup)
        # Query for finding all orders where werkbonnen have a specific status and backup status
        Order.joins(:vloers).group(:id).where(:vloers => { :status => status, :backup => backup })
    end

end
