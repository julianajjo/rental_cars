require 'rails_helper'

feature 'Admin search customer' do
  scenario 'from partial name' do
    #Arrange
    user = create(:user)
    create(:customer, name: 'Ana Silva', email: 'ana@email.com')
    create(:customer, name: 'André Silva', email: 'andre@email.com')

    #Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    fill_in 'Busca', with: 'André'
    click_on 'Buscar'

    #Assert
    expect(current_path).to eq search_customers_path
    expect(page).to have_content 'André Silva'
    expect(page).to have_content 'andre@email.com'

    expect(page).not_to have_content 'Ana Silva'
    expect(page).not_to have_content 'ana@email.com'
  end

  scenario 'from partial name with multiple results' do
   #Arrange
   user = create(:user)
   create(:customer, name: 'Ana Silva', email: 'ana@email.com')
   create(:customer, name: 'André Silva', email: 'andre@email.com')
   create(:customer, name: 'Carlos Oliveira', email: 'carlos@email.com')

   #Act
   login_as(user, scope: :user)
   visit root_path
   click_on 'Clientes'
   fill_in 'Busca', with: 'Silva'
   click_on 'Buscar'

   #Assert 
    expect(current_path).to eq search_customers_path
    expect(page).to have_content 'Resultado da busca por: Silva'
    expect(page).to have_content '2 clientes encontrados'

    expect(page).to have_content 'André Silva'
    expect(page).to have_content 'andre@email.com'

    expect(page).to have_content 'Ana Silva'
    expect(page).to have_content 'ana@email.com'

    expect(page).not_to have_content 'Carlos Oliveira'
    expect(page).not_to have_content 'carlos@email.com'

  end

  scenario 'from cpf' do
    #Arrange
    user = create(:user)
    create(:customer, name: 'Ana Silva', email: 'ana@email.com', 
           cpf: '18885510205')
    create(:customer, name: 'André Silva', email: 'andre@email.com')
    
    #Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    fill_in 'Busca', with: '18885510205'
    click_on 'Buscar'
 
    #Assert 
     expect(current_path).to eq search_customers_path
     expect(page).to have_content 'Resultado da busca por: 18885510205'
     #expect(page).to have_content '1 cliente encontrado'
 
     expect(page).to have_content 'Ana Silva'
     expect(page).to have_content 'ana@email.com'
 
     expect(page).not_to have_content 'André Silva'
     expect(page).not_to have_content 'andre@email.com'
   end
end