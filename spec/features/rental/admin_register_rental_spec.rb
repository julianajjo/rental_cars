require 'rails_helper'

feature 'Admin register rental' do
    scenario 'successfully' do
      car_category = create(:car_category, name: 'A')
      customer = create(:customer, name: 'Fulano Sicrano', cpf: '57810023594', 
                        email: 'teste@teste.com.br')

      user = create(:user)
      mail = double('RentalMailer')
      allow(RentalMailer).to receive(:rental_scheduled).and_return(mail)
      allow(mail).to receive(:deliver_now)
  
      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: user.password
      click_on 'Log in'
      click_on 'Locações'
      click_on 'Registrar locação'
      fill_in 'Data inicial', with: '16/04/2030'
      fill_in 'Data final', with: '18/04/2030'
      select car_category.name, from: 'Categoria'
      select 'Fulano Sicrano - 578.100.235-94', from: 'Cliente'
      click_on 'Enviar' 
      
      expect(RentalMailer).to have_received(:rental_scheduled)
      expect(page).to have_content('16/04/2030')
      expect(page).to have_content('18/04/2030')
      expect(page).to have_content(customer.identification)
      expect(page).to have_content(/A/)
      expect(page).to have_content('Locação cadastrada com sucesso')
    end
    
    scenario 'and must fill all fields' do
      user = create(:user)

      login_as(user, scope: :user)
      visit root_path
      click_on 'Locações'
      click_on 'Registrar locação'
      click_on 'Enviar'
  
      expect(page).to have_content('Data inicial não pode ficar em branco')
      expect(page).to have_content('Data final não pode ficar em branco')
      expect(page).to have_content('Cliente é obrigatório(a)')
      expect(page).to have_content('Categoria é obrigatório(a)')
    end

end