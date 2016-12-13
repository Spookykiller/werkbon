class VloersController < ApplicationController
    before_action :authenticate_user!
    layout 'werkbonnen'
    before_action :find_vloer, only: [:print, :duplicate, :edit, :update, :destroy]
    before_action :find_order, only: [:index, :new, :create, :print, :duplicate, :edit, :update, :destroy]

    def index
        @vloers = Vloer.where(:order => @order)
    end
    
    def new
        @vloer = Vloer.new
        @leveranciers = Leverancier.all.order("sequence_id ASC")
    end
    
    def find_pakbon
        respond_to do |format|
            format.js
        end
    end
    
    def create
        @order = Order.find(params[:order_id])
        @vloer = Vloer.new vloer_params
        @vloer.order_id = @order.id
        
        if @vloer.save
            flash[:notice] = "De werkbon is opgeslagen!"
            redirect_to action: "index"
        else
            render 'new'
            flash[:notice] = "Oh nee! De werkbon is niet opgeslagen."
        end
    end
    
    def duplicate
        new_record = @vloer.dup
        new_record.werkvoorbereider = current_user.fullname
        
        if new_record.save 
            @vloer.items.each do |item|
                new_record.items.create(item.dup.attributes)
            end
            
            @vloer.calculations.each do |calculation|
                new_record.calculations.create(calculation.dup.attributes)
            end
            flash[:notice] = "De werkbon is gedupliceerd!"
            redirect_to edit_order_vloer_path(@order, new_record)
        else
            redirect_to action: "index"
            flash[:notice] = "Oh nee! De werkbon is niet gedupliceerd."
        end
    end
    
    def print
        @items = @vloer.items.order("created_at ASC")
    end
    
    def edit
        @items = @vloer.items.order("created_at ASC")
    end
    
    def update
        if @vloer.update vloer_params
            flash[:notice] = "De werkbon is succesvol aangepast."
            redirect_to action: "index"
        else
            flash[:notice] = "Oh nee! De werbon kon niet opgeslagen worden."
            render 'edit'
        end
    end
    
    def destroy
        @vloer.destroy
        redirect_to action: "index"
    end
    
    private
    
    def vloer_params
        params.require(:vloer).permit(:status, :order, :organisatie, :datum, :werkvoorbereider, :werkbon_type, :totale_prijs, :totale_arbeid, :bijzonderheden, items_attributes: [:id, :ref_id, :hoeveelheid, :omschrijving, :var1, :var1_name, :var2, :var2_name, :var3, :var3_name, :var4, :var4_name, :article_prijs, :prijs, :totale_prijs, :totale_arbeid, :werkbon_type, :_destroy], calculations_attributes: [:id, :werkbon, :ruimte, :aantal, :breedte, :hoogte, :strakke_hoogte_maat, :bmdm, :stuks, :hoofdje, :rail_lengte, :montage, :bediening, :montage_hoogte, :plaatsing, :bed, :type, :uitlijnen, :knipmaat, :bocht_type, :bocht_maat, :snijmaat, :ondervloer, :legrichting, :_destroy] )
    end
    
    def find_vloer
        @vloer = Vloer.find(params[:id]) 
    end
    
    def find_order
        @order = Order.find(params[:order_id])
    end
    
end
