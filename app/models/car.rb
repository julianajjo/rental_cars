class Car < ApplicationRecord
  belongs_to :car_model

  def description
    "#{car_model.manufacturer.name} #{car_model.name} - Placa: #{licence_plate} - Cor: #{color}"
  end
end
