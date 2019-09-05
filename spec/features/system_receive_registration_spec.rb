require 'rails_helper'

feature 'system receive registration' do
  scenario 'successfully' do
    # arrange
    unity = Unity.create(name: 'Paulista')
    plan = Plan.create(name: 'Master')
    user = create(:user)

    # act
    login_as user
    visit root_path

    click_on 'New registration'

    fill_in 'Nome', with: 'Fulano de Tal'
    fill_in 'Email', with: 'fulano@tal.com'
    select 'Paulista', from: 'Unidade'
    select 'Master', from: 'Plano'
    click_on 'Enviar'

    # assert
    expect(page).to have_css('h2', text: 'Fulano de Tal')
    expect(page).to have_css('p', text: 'fulano@tal.com')
    expect(page).to have_css('p', text: 'Paulista')
    expect(page).to have_css('p', text: 'Master')
  end

  scenario 'and must be fill' do
    # arrange
    unity = Unity.create(name: 'Paulista')
    plan = Plan.create(name: 'Master')
    user = create(:user)

    # act
    login_as user
    visit root_path

    click_on 'New registration'

    fill_in 'Nome', with: ' '
    fill_in 'Email', with: ' '
    select 'Paulista', from: 'Unidade'
    select 'Master', from: 'Plano'
    click_on 'Enviar'

    # assert
    expect(page).to have_content('Todos os campos devem estar preenchidos.')
  end

  scenario 'and only admin access for url' do
    # act
    visit new_registration_path

    # assert
    expect(page).to_not have_link('New registration')
  end
end