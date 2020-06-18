require 'rails_helper'

feature 'User search rental' do
  scenario 'sucessfully' do
    user = create(:user)
      car_category = create(:car_category)
      customer = create(:customer)
      rental = create(:rental, customer: customer, car_category: car_category)
      another_rental = create(:rental, customer: customer, car_category: car_category)

      login_as user, scope: :user
      visit root_path
      click_on 'Locações'
      fill_in 'Busca', with: rental.code
      click_on 'Pesquisar'

      expect(page).to have_content(rental.code)
      expect(page).not_to have_content(another_rental.code)

    
  end
end