class LeveranciersController < ApplicationController
    before_action :authenticate_user!
    before_action :find_leverancier, only: [:edit, :update, :destroy]

    def index
        @leveranciers = Leverancier.all.order("sequence_id ASC")
    end
    
    def new
        @leverancier = Leverancier.new
    end
    
    def find_pakbon
        respond_to do |format|               
            format.js
        end
    end
    
    def create
        @leverancier = Leverancier.new leverancier_params

        if @leverancier.save
            flash[:notice] = "De leverancier is opgeslagen!"
            redirect_to action: "index"
        else
            render 'new'
            flash[:notice] = "Oh nee! De leverancier is niet opgeslagen."
        end
    end
    
    def edit
    end
    
    def update
        if @leverancier.update leverancier_params
            flash[:notice] = "De leverancier is succesvol aangepast."
            redirect_to action: "index"
        else
            flash[:notice] = "Oh nee! De leverancier kon niet opgeslagen worden."
            render 'edit'
        end
    end
    
    def destroy
        @leverancier.destroy
        redirect_to action: "index"
    end
    
    private
    
    def leverancier_params
        params.require(:leverancier).permit(:sequence_id, :leverancier_werkbon, :leverancier_label, :voorraad_actie, leverancier_regels_attributes: [:id, :input, :_destroy] )
    end
    
    def find_leverancier
       @leverancier = Leverancier.find(params[:id]) 
    end

end
