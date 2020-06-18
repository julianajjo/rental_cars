require 'rails_helper'

feature 'Visitor view manufacturers' do
  scenario 'successfully' do
    #Arrange
    create(:manufacturer, name: 'Fiat')
    create(:manufacturer, name: 'Volkswagen')
    user = create(:user)

    login_as(user, scope: :user)
    #Act
    visit root_path
    click_on 'Fabricantes'

    #Assert
    expect(page).to have_content('Fiat')
    expect(page).to have_content('Volkswagen')
  end

  scenario 'and view details' do
    create(:manufacturer, name: 'Fiat')
    create(:manufacturer, name: 'Volkswagen')
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'

    expect(page).to have_content('Fiat')
    expect(page).not_to have_content('Volkswagen')
  end

  scenario 'and no manufacturers are created' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'

    expect(page).to have_content('Nenhum fabricante cadastrado')
  end

  scenario 'and return to home page' do
    create(:manufacturer, name: 'Fiat')
    create(:manufacturer, name: 'Volkswagen')
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to manufacturers page' do
    create(:manufacturer, name: 'Fiat')
    create(:manufacturer, name: 'Volkswagen')
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Voltar'

    expect(current_path).to eq manufacturers_path
  end

end
