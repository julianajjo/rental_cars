require 'rails_helper'

feature 'Admin begin rental' do
  scenario 'from customer search' do
    #Arrange
    user = User.create!(email: 'test@test.com', password: '12345678')
    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, third_part_insurance: 100)
    customer = Customer.create!(name: 'Fulano Sicrano', cpf: '57810023594', email: 'teste@teste.com.br')
    rental = Rental.create!(start_date: '16/04/2030', end_date: '18/04/2030', customer: customer, car_category: car_category)

    #Act
    login_as(user)
    visit root_path
    click_on 'Clientes'
    fill_in 'Busca', with: '57810023594'
    click_on 'Buscar'
    click_on 'Fulano Sicrano'
    
    #Assert
    expect(current_path).to eq customer_path(customer.id)
    expect(page).to have_content rental.code
    expect(page).to have_content 'Categoria A'
    expect(page).to have_link('Iniciar Locação', href: start_rental_path(rental.id))
  end

  scenario 'and view available cars' do
    #Arrange
    user = User.create!(email: 'test@test.com', password: '12345678')
    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, third_part_insurance: 100)
    another_category = CarCategory.create!(name: 'B', daily_rate: 200, car_insurance: 200, third_part_insurance: 200)
    fiat = Manufacturer.create!(name: 'Fiat')
    mobi = CarModel.create!(name: 'Mobi', manufacturer: fiat, car_category: car_category)
    argos = CarModel.create!(name: 'Argos', manufacturer: fiat, car_category: another_category)
    car = Car.create(car_model: mobi, license_plate: 'ABC-1234', mileage: 1000, color: 'Azul')
    another_car = Car.create(car_model: argos, license_plate: 'XYZ-9876', mileage: 0, color: 'Preto')
    
    customer = Customer.create!(name: 'Fulano Sicrano', cpf: '57810023594', email: 'teste@teste.com.br')
    rental = Rental.create!(start_date: '16/04/2030', end_date: '18/04/2030', customer: customer, car_category: car_category)

    #Act
    login_as(user, scope: :user)
    visit customer_path(customer.id)
    click_on 'Iniciar Locação'
  
    #Asset
    expect(current_path).to eq start_rental_path(rental.id)
    expect(page).to have_content rental.code
    expect(page).to have_content 'Categoria A'
    expect(page).to have_content 'Fiat Mobi - Placa: ABC-1234 - Cor: Azul'
    expect(page).not_to have_content 'Fiat Argos - Placa: XYZ-9876 - Cor: Preto'
  end

  scenario 'successfully' do
    # Arrange
    user = User.create!(email: 'test@test.com', password: '12345678')
    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, third_part_insurance: 100)

    fiat = Manufacturer.create!(name: 'Fiat')
    mobi = CarModel.create!(name: 'Mobi', manufacturer: fiat, car_category: car_category)
    car = Car.create(car_model: mobi, license_plate: 'ABC-1234', mileage: 1000, color: 'Azul', status: :available)

    customer = Customer.create!(name: 'Fulano Sicrano', cpf: '57810023594', email: 'teste@teste.com.br')

    rental = Rental.create!(start_date: '16/04/2030', end_date: '18/04/2030', customer: customer, car_category: car_category)

    # Act
    login_as(user, scope: :user)
    visit start_rental_path(rental.id)
    select 'Fiat Mobi - Placa: ABC-1234 - Cor: Azul', from: 'Carro'

    travel_to Time.zone.local(2020, 05, 01, 13, 00, 00) do
      click_on 'Confirmar'  
    end
    
   
    # Assert
    rental.reload
    car.reload    
    expect(rental.ongoing?).to be true
    expect(car.rented?).to be true
    expect(current_path).to eq rental_path(rental.id)
    expect(page).to have_content 'Status Iniciada'
    expect(page).to have_content 'Fulano Sicrano'
    expect(page).to have_content 'Horário da Retirada: 01/05/2020 13:00:00'
    expect(page).to have_content 'Usuário Responsável: test@test.com'
    expect(page).to have_content 'Fiat Mobi - Placa: ABC-1234 - Cor: Azul'    
  end
end