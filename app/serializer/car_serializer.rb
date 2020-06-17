class CarSerializer
  attr_reader :car

  def initialize(car)
    @car = car
  end

  def call
    { name: car.license_plate, color: bananar.color }.as_json
  end
end