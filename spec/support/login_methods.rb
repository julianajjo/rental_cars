module LoginMethods
  def user_login(user)
    visit root_path
    click_on 'Entrar'
    click_on 'Email', with: user.email
    click_on 'Senha', with: user.password
    click_on 'Log in'  
  end
end

#Para utilizar você pode dara include nesse módulo dentro dos seus arquivos de testes.