require 'rails_helper'

feature 'Admin view all subsidiaries' do
  scenario  'must be signed in' do
  
    #Arrange é vazio

    #Act
    visit root_path
    click_on 'Filiais'

    #Assert
    expect(current_path).to eq new_user_session_path
  end

  scenario 'view all subsidiaries' do
    #Arrange
    Subsidiary.create!(name: 'Paulista', address: 'Avenida Paulista, 1000', cnpj: '08285486000163')
    Subsidiary.create!(name: 'Cuiabá', address: 'Avenida do Comércio, 50', cnpj: '07553845000153')

    User.create!(email: 'joao@email.com', password: '12345678') 

    #Act
    visit root_path
    click_on 'Filiais'
    fill_in 'Email', with: 'joao@email.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Log in'
    click_on 'Filiais'

    #Assert
    expect(page).to have_content 'Paulista'
    expect(page).to have_content 'Avenida Paulista, 1000'

  end

  scenario 'view all subsidiaries' do
    #Arrange
    User.create!(email: 'joao@email.com', password: '12345678') 

    #Act
    visit root_path
    click_on 'Filiais'
    fill_in 'Email', with: 'joao@email.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Log in'
    click_on 'Filiais'

    #Assert
    expect(page).to have_content 'Nenhuma filial cadastrada'
    
  end
    
end