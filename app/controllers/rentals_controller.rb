class RentalsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :start, :confirm]

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

  def confirm
    @rental = Rental.find(params[:id])
    @car = Car.find(params[:car_id])
    @user = current_user

    begin
      ActiveRecord::Base.transaction do
        @rental.ongoing!    
        @car.rented!
        
        CarRental.create!(rental: @rental, car: @car, start_date: Time.zone.now, user: @user, daily_rate: @rental.car_category.daily_rate, 
                        car_insurance: @rental.car_category.car_insurance, third_part_insurance: @rental.car_category.third_part_insurance)
      end
    rescue 
      logger.error "#{@rental.code} - Não foi possível iniciar a locação"
    end

    redirect_to @rental
  end

  def show
    @rental = Rental.find(params[:id])
  end
end
