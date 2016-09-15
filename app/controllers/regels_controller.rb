class RegelsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_regel, only: [:duplicate ,:edit, :update, :destroy]

    def index
        @regels = Regel.all
    end
    
    def new
        @regel = Regel.new
    end
    
    def new_blanko
        @regel = Regel.new
    end
    
    def find_pakbon
        respond_to do |format|               
            format.js
        end
    end
    
    def create
        @regel = Regel.new regel_params

        if @regel.save
            flash[:notice] = "De regel is opgeslagen!"
            redirect_to action: "index"
        else
            render 'new'
            flash[:notice] = "Oh nee! De regel is niet opgeslagen."
        end
    end
    
    def duplicate
        new_record = @regel.dup

        if new_record.save 
            flash[:notice] = "De regel is gedupliceerd!"
            redirect_to action: "index"
        else
            redirect_to action: "index"
            flash[:notice] = "Oh nee! De regel is niet gedupliceerd."
        end
    end
    
    def edit
    end
    
    def update
        if @regel.update regel_params
            flash[:notice] = "Uw regel is succesvol aangepast."
            redirect_to action: "index"
        else
            flash[:notice] = "Oh nee! Uw regel kon niet opgeslagen worden."
            render 'edit'
        end
    end
    
    def destroy
        @regel.destroy
        redirect_to action: "index"
    end
    
    private
    
    def regel_params
        params.require(:regel).permit(:werkbon, :article_type, :leverancier_name, :label, :var_1_eenheid, :var_2_eenheid, dropdowns_attributes: [:id, :input, :article_type, :_destroy], second_dropdowns_attributes: [:id, :input, :article_type, :_destroy] )
    end
    
    def find_regel
       @regel = Regel.find(params[:id]) 
    end
end
