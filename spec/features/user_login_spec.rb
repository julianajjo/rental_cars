require 'rails_helper'

feature 'User log in and log out' do
  scenario 'successfully' do
    User.create!(email: 'test@test.com.br', password: '12345678')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'test@test.com.br'
    fill_in 'Senha', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_link('Fabricante')
    expect(page).to have_link('Categorias de Carros')
    expect(page).to have_link('Modelos de Carros')
    expect(page).to have_link('Locações')
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Entrar')
  end

  scenario 'successfully' do
    User.create!(email: 'test@test.com.br', password: '12345678')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'test@test.com.br'
    fill_in 'Senha', with: '12345678'
    click_on 'Log in'
    click_on 'Logout'

    expect(page).to have_content('Saiu com sucesso')
    expect(page).not_to have_link('Logout')
    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Locações')
    #expect(page).not_to have_link('Fabricante')
    #expect(page).not_to have_link('Categorias de Carros')
    #expect(page).not_to have_link('Modelos de Carros')

    # TODO Fazer entrar no caminho apenas quando estiver logado - falta ter que passar em todas as rotas
    end

end