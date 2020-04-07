class ManufacturersController < ApplicationController
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
      @manufacturer.save
      redirect_to @manufacturer
    end

end
