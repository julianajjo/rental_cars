require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'from index page' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'

    expect(page).to have_link('Registrar novo fabricante', 
                               href: new_manufacturer_path)
  end

  scenario 'successfully' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(current_path).to eq manufacturer_path(Manufacturer.last.id)
    expect(page).to have_content('Fiat')
  end

  scenario 'and name can not be blank' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(Manufacturer.count).to eq 0
    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and name must be unique' do
    user = create(:user)

    login_as(user, scope: :user)
    Manufacturer.create!(name: 'Fiat' )
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(Manufacturer.count).to eq 1
    expect(page).to have_content('Nome já está em uso')
  end

end

