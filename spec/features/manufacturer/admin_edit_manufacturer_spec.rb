require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    manufacturer = create(:manufacturer, name: 'Fiat')
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(current_path).to eq manufacturer_path(manufacturer.id)
    expect(page).to have_content('Honda')
    expect(page).not_to have_content('Fiat')
  end

  scenario 'successfully' do
    create(:manufacturer, name: 'Fiat')
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'successfully' do
    create(:manufacturer, name: 'Fiat')
    create(:manufacturer, name: 'Honda')
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end
   
end
