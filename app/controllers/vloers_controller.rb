class VloersController < ApplicationController
    before_action :authenticate_user!
    layout 'werkbonnen'
    before_action :find_vloer, only: [:print, :duplicate, :edit, :update, :destroy]
    before_action :find_order_state, only: [:index, :new, :create, :print, :duplicate, :edit, :update, :destroy]
    before_action :find_order, only: [:index, :new, :create, :print, :duplicate, :edit, :update, :destroy]

    def index
        @vloers = Vloer.where(:order_states_id => @order_state)
    end
    
    def new
        @vloer = Vloer.new
        # leveranciers laden in volgorde van sequence_id (rijnummer)
        @leveranciers = Leverancier.all.order("sequence_id ASC")
    end
    
    def find_pakbon
        respond_to do |format|
            format.js
        end
    end
    
    def create
        @vloer = Vloer.new vloer_params
        # zet de orderstatus van de nieuwe werkbon gelijk aan de orderstatus id
        @vloer.order_states_id = @order_state.id
        # status van de werkbon op offerte initialiseren
        @vloer.status = 0
        
        if @vloer.save
            flash[:notice] = "De werkbon is aangemaakt!"
            redirect_to order_order_states_path(@order)
        else
            render 'new'
            flash[:alert] = "Oh nee! De werkbon is niet aangemaakt."
        end
    end
    
    def duplicate
        
        if @vloer.status == 0
            # aanmaken orderstatus order met status meting
            new_order = OrderState.create(:status => 1, :order_id => @order.id)
            new_order = OrderState.where(:status => 1, :order_id => @order.id).first
        # wanneer de werkbonstatus 'klaar voor meting' (1) is wanneer op de knop wordt gedrukt    
        elsif @vloer.status == 2
            # aanmaken duplicaat  order met status definitief
            new_order = OrderState.create(:status => 2, :order_id => @order.id)
            new_order = OrderState.where(:status => 2, :order_id => @order.id).first
        # wanneer er een duplicaat van de werkbon gemaakt moet worden in de huidige order  
        elsif @vloer.status == 5
            redirect_to orders_path
            flash[:alert] = "Laatste status is bereikt"
            return false
        end

        # werkbon in nieuwe/bestaande order wordt gedefineerd vanuit vorige werkbon (duplicaat aangemaakt)
        new_vloer = @vloer.dup
        # de nieuwe werkbon heeft een status die 1 hoger is dan de vorige
        new_vloer.status = (@vloer.status + 1)
        if new_order.blank?
            new_vloer.order_states_id = @vloer.order_states_id
        else
            new_vloer.order_states_id = new_order.id
        end
        
        if new_vloer.save
            # maak alle item attributen van de relaties van de werkbon aan
            @vloer.items.each do |item|
                new_vloer.items.create(item.dup.attributes)
            end
            
            # maak alle calculatie attributen van de relaties van de werkbon aan
            @vloer.calculations.each do |calculation|
                new_vloer.calculations.create(calculation.dup.attributes)
            end
            flash[:notice] = "Werkbon is naar volgende fase"
            
            # zet de werkbon waar je zojuist op geklikt hebt op backup mode
            @vloer.update_attribute(:backup,true)
        else
            flash[:alert] = "Er is iets fout gegaan!"
        end
    
        flash[:notice] = "Er is een backup gemaakt!"
        redirect_to order_order_states_path(@order)

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
            redirect_to order_order_states_path(@order)
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
        params.require(:vloer).permit(:name, :backup, :status, :order, :organisatie, :datum, :werkvoorbereider, :werkbon_type, :totale_prijs, :totale_arbeid, :bijzonderheden, items_attributes: [:id, :ref_id, :hoeveelheid, :omschrijving, :var1, :var1_name, :var2, :var2_name, :var3, :var3_name, :var4, :var4_name, :article_prijs, :prijs, :totale_prijs, :totale_arbeid, :werkbon_type, :_destroy], calculations_attributes: [:id, :werkbon, :ruimte, :aantal, :breedte, :hoogte, :pakket, :zijgeleiding, :contra_rolend, :strakke_hoogte_maat, :bmdm, :stuks, :hoofdje, :rail_lengte, :type_roede, :montage, :bediening, :montage_hoogte, :plaatsing, :bed, :raam_type, :uitlijnen, :knipmaat, :koof, :raam_montage, :bocht_type, :bocht_maat, :snijmaat, :ondervloer, :legrichting, :_destroy] )
    end
    
    def find_vloer
        @vloer = Vloer.find(params[:id]) 
    end
    
    def find_order_state
        @order_state = OrderState.find(params[:order_state_id])
    end
    
    def find_order
        @order = Order.find(params[:order_id])
    end

end
