require 'rails_helper'

feature 'Admin deletes manufacturer' do
  scenario 'successfully' do
    create(:manufacturer, name: 'Fiat')

    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Apagar fabricante'

    expect(current_path).to eq manufacturers_path
    expect(page).to have_content('Nenhum fabricante cadastrado')
  end

  scenario 'and keep anothers' do
    create(:manufacturer, name: 'Fiat')
    create(:manufacturer, name: 'Honda')

    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Apagar fabricante'

    expect(current_path).to eq manufacturers_path
    expect(page).not_to have_content('Fiat')
    expect(page).to have_content('Honda')
  end

end
