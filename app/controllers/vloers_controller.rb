class VloersController < ApplicationController
    before_action :authenticate_user!
    before_action :find_vloer, only: [:print, :duplicate, :edit, :update, :destroy]

    def index
        @vloers = Vloer.all
    end
    
    def new
        @vloer = Vloer.new
        @test = "Vloeren"
    end
    
    def find_pakbon
        respond_to do |format|
            format.js
        end
    end
    
    def create
        @vloer = Vloer.new vloer_params

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
        
        if new_record.save 
            flash[:notice] = "De werkbon is gedupliceerd!"
            redirect_to action: "index"
        else
            redirect_to action: "index"
            flash[:notice] = "Oh nee! De werkbon is niet gedupliceerd."
        end
    end
    
    def print
    end
    
    def edit
    end
    
    def update
        if @vloer.update vloer_params
            flash[:notice] = "Uw werkbon is succesvol aangepast."
            redirect_to action: "index"
        else
            flash[:notice] = "Oh nee! Uw werbon kon niet opgeslagen worden."
            render 'edit'
        end
    end
    
    def destroy
        @vloer.destroy
        redirect_to action: "index"
    end
    
    private
    
    def vloer_params
        params.require(:vloer).permit(:naam, :project_nummer, :project_naam, :AdressLine1, :AdressLine3, :AdressLine4, :telefoon, :email, :organisatie, :contactpersoon, :datum, :werkvoorbereider, :oplevering, :ordernummer, :werkbon_type, :totale_prijs, :totale_arbeid, :bijzonderheden, items_attributes: [:id, :voorraad_actie, :hoeveelheid, :omschrijving, :var1, :var1_name, :var2, :var2_name, :var3, :var3_name, :var4, :var4_name, :article_prijs, :prijs, :totale_prijs, :totale_arbeid, :werkbon_type, :_destroy], calculations_attributes: [:id, :werkbon, :ruimte, :breedte, :hoogte, :stuks, :bed, :voeren, :hoofdje, :bediening, :type, :uitlijnen, :bmdm, :_destroy] )
    end
    
    def find_vloer
       @vloer = Vloer.find(params[:id]) 
    end

end
