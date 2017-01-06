class VloersController < ApplicationController
    before_action :authenticate_user!
    layout 'werkbonnen'
    before_action :set_status_werkbon, only: [:new, :edit]
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
        @vloer.status = 0
        
        if @vloer.save
            flash[:notice] = "De werkbon is opgeslagen!"
            redirect_to action: "index"
        else
            render 'new'
            flash[:notice] = "Oh nee! De werkbon is niet opgeslagen."
        end
    end
    
    def duplicate
        if @vloer.status == 0
            # aanmaken duplicaat order met status meting
            new_order = @vloer.order.dup
            new_order.status = 1
        # wanneer de werkbonstatus 'klaar voor meting' (1) is wanneer op de knop wordt gedrukt    
        elsif @vloer.status == 1
            # aanmaken duplicaat  order met status definitief
            new_order = @vloer.order.dup
            new_order.status = 2
        # wanneer er een duplicaat van de werkbon gemaakt moet worden in de huidige order   
        else
            new_order = @vloer.order
        end

        if new_order.save
            # wanneer de werkbonstatus een offerte (0) is wanneer op de knop wordt gedrukt
            
            # werkbon in nieuwe/bestaande order wordt gedefineerd vanuit vorige werkbon (duplicaat aangemaakt)
            new_vloer = @vloer.dup
            # de nieuwe werkbon heeft een status die 1 hoger is dan de vorige
            new_vloer.status = (@vloer.status + 1)
            new_vloer.order_id = new_order.id
            puts "NEW ORDER ID"
            puts new_order.id
            puts new_vloer.order_id
            
            if new_vloer.save
                # maak alle item attributen van de relaties van de werkbon aan
                @vloer.items.each do |item|
                    new_vloer.items.create(item.dup.attributes)
                end
                
                # maak alle calculatie attributen van de relaties van de werkbon aan
                @vloer.calculations.each do |calculation|
                    new_vloer.calculations.create(calculation.dup.attributes)
                end
                flash[:notice] = "Werkbon is opgeslagen"

                @vloer.update_attribute(:backup,true)
            else
                flash[:notice] = "Werkbon is niet opgeslagen"
            end
        
            flash[:notice] = "De werkbon is gedupliceerd!"
            redirect_to orders_path
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
        params.require(:vloer).permit(:backup, :status, :order, :organisatie, :datum, :werkvoorbereider, :werkbon_type, :totale_prijs, :totale_arbeid, :bijzonderheden, items_attributes: [:id, :ref_id, :hoeveelheid, :omschrijving, :var1, :var1_name, :var2, :var2_name, :var3, :var3_name, :var4, :var4_name, :article_prijs, :prijs, :totale_prijs, :totale_arbeid, :werkbon_type, :_destroy], calculations_attributes: [:id, :werkbon, :ruimte, :aantal, :breedte, :hoogte, :pakket, :zijgeleiding, :contra_rolend, :strakke_hoogte_maat, :bmdm, :stuks, :hoofdje, :rail_lengte, :type_roede, :montage, :bediening, :montage_hoogte, :plaatsing, :bed, :raam_type, :uitlijnen, :knipmaat, :koof, :raam_montage, :bocht_type, :bocht_maat, :snijmaat, :ondervloer, :legrichting, :_destroy] )
    end
    
    def find_vloer
        @vloer = Vloer.find(params[:id]) 
    end
    
    def find_order
        @order = Order.find(params[:order_id])
    end
    
    def set_status_werkbon
        @status_label = "Dit is een test"
        @status_int = 2
    end
    
end
