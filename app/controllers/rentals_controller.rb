class RentalsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @rentals = Rental.all
  end

  def new
    @rental = Rental.new
    @car_categories = CarCategory.all
    @customers = Customer.all
  end

  def create
    @rental = Rental.new(params.require(:rental).permit(:start_date, :end_date, :car_category_id, :customer_id))
    if @rental.save
      flash[:sucess] = 'Locação cadastrada com sucesso'
    redirect_to rentals_path
    else
      @car_categories = CarCategory.all
      @customers = Customer.all
      render :new
    end
  end

  def search
    @rentals = Rental.where(code: params[:q])
    render :index
  end

  def start
    @rental = Rental.find(params[:id])
    car_models = @rental.car_category.car_models
    @available_cars = Car.where(car_model: car_models)
  end
end
