require 'rails_helper'

feature 'Admin view car models available' do
  scenario 'sucessfully' do
    #Arrange
    fiat = create(:manufacturer, name: 'Fiat')
    honda = create(:manufacturer, name: 'Honda')
    cat_a = create(:car_category, name: 'A', daily_rate: 50, car_insurance: 20,
                   third_part_insurance: 20)
    cat_d = create(:car_category, name: 'D', daily_rate: 150, car_insurance: 60, 
                   third_part_insurance: 30)
    CarModel.create!(name: 'Mobi', manufacturer: fiat, car_category: cat_a)
    CarModel.create!(name: 'Civic', manufacturer: honda, car_category: cat_d)

    user = create(:user)

    login_as(user, scope: :user)
    #Act
    visit root_path
    click_on "Modelos de Carros"

    #Assert
    expect(page).to have_content('Fiat')
    expect(page).to have_content('Mobi')
    expect(page).to have_content('A')

    expect(page).to have_content('Honda')
    expect(page).to have_content('Civic')
    expect(page).to have_content('D')
  end

end