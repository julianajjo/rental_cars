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
      @manufacturer = Manufacturer.new
      @manufacturer.name = params[:manufcturer][:name]
      @manufacturer.save
      redirect_to @manufacturer
    end

end
