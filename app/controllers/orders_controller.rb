class OrdersController < ApplicationController
    before_action :authenticate_user!
    layout 'werkbonnen'
    before_action :find_order, only: [:print, :duplicate, :edit, :update, :destroy]
    helper_method :sort_column, :sort_direction

    def index
        @orders = Order.order(sort_column + " " + sort_direction)
    end
    
    def new
        @order = Order.new
    end
    
    def create
        @order = Order.new order_params

        if @order.save
            flash[:notice] = "De order is opgeslagen!"
            redirect_to action: "index"
        else
            render 'new'
            flash[:notice] = "Oh nee! De order is niet opgeslagen."
        end
    end
    
    def duplicate
        new_record = @order.dup
        
        if new_record.save 
            flash[:notice] = "De order is gedupliceerd!"
            redirect_to action: "index"
        else
            redirect_to action: "index"
            flash[:notice] = "Oh nee! De order is niet gedupliceerd."
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
        params.require(:order).permit(:naam, :project_nummer, :project_naam, :AdressLine1, :AdressLine3, :AdressLine4, :navigatie_adres, :telefoon, :email, :contactpersoon, :inmeetdatum, :oplevering, :ordernummer, :totale_prijs, :totale_arbeid, items_attributes: [:id, :voorraad_actie, :hoeveelheid, :omschrijving, :var1, :var1_name, :var2, :var2_name, :var3, :var3_name, :var4, :var4_name, :article_prijs, :prijs, :totale_prijs, :totale_arbeid, :werkbon_type, :_destroy], calculations_attributes: [:id, :werkbon, :ruimte, :breedte, :hoogte, :stuks, :bed, :voeren, :hoofdje, :bediening, :type, :uitlijnen, :bmdm, :_destroy] )
    end
    
    def find_order
       @order = Order.find(params[:id]) 
    end
    
    def sort_column
        Order.column_names.include?(params[:sort]) ? params[:sort] : "inmeetdatum"
    end
  
    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
