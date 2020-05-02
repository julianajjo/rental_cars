class ManufacturersController < ApplicationController
    before_action :authenticate_user!, only: [:show]

    def index
      @manufacturers = Manufacturer.all
    end

    def show
      @manufacturer = Manufacturer.find(params[:id])
    end

    def new
      @manufacturer = Manufacturer.new
    end

    def create
      @manufacturer = Manufacturer.new(params.require(:manufacturer).permit(:name))     
     if  @manufacturer.save
      redirect_to @manufacturer
     else 
      render 'new'
     end
    end

    def edit
      @manufacturer = Manufacturer.find(params[:id])
    end

    def update
      @manufacturer = Manufacturer.find(params[:id])
     if  @manufacturer.update(name: params[:manufacturer][:name])
      redirect_to @manufacturer
     else
      render 'edit'
     end
    end

    def destroy
      @manufacturer = Manufacturer.find(params[:id])
      @manufacturer.delete
      redirect_to manufacturers_path
    end
end
