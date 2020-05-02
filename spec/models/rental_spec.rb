require 'rails_helper'

RSpec.describe Rental, type: :model do
  context '#code' do
    it 'create automatically' do
      car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, third_part_insurance: 100)
      client = Client.create!(name: 'Fulano Sicrano', document: '578.100.235-94', email: 'teste@teste.com.br')
      rental = Rental.new(start_date: '16/04/2030', end_date: '18/04/2030', client: client, car_category: car_category)

      rental.save!

      expect(rental.code.size).to eq(6)
    end
  end


end
