require 'rails_helper'

feature 'system receive registration' do
  scenario 'successfully' do
    # arrange
    unity = create(:unity, name: 'Paulista')
    plan = create(:plan, name: 'Master')
    user = create(:user)

    # act
    login_as user
    visit root_path

    click_on 'New registration'

    fill_in 'Nome', with: 'Fulano de Tal'
    fill_in 'CPF', with: '123456789'
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
    unity = create(:unity, name: 'Paulista')
    plan = create(:plan, name: 'Master')
    user = create(:user)

    # act
    login_as user
    visit root_path

    click_on 'New registration'

    fill_in 'Nome', with: ' '
    fill_in 'Email', with: ' '
    fill_in 'CPF', with: ' '
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
    expect(current_path).to eq new_user_session_path
  end

  scenario 'and do not duplicate' do
    user = create(:user)
    create(:registration)

    login_as user
    visit root_path
    click_on 'New registration'

    fill_in 'Nome', with: 'Fulano de Tal'
    fill_in 'Email', with: 'email@email.com'
    fill_in 'CPF', with: '123456789'
    select 'Paulista', from: 'Unidade'
    select 'Master', from: 'Plano'
    click_on 'Enviar'

    expect(page).to have_content('Todos os campos devem estar preenchidos.')
  end

  scenario 'and generate 12 monthly payment' do
    user = create(:user)
    plan = create(:plan, value: 80.0)
    registration = create(:registration, name: 'Fulano de tal', plan: plan)

    login_as user
    visit root_path

    click_on registration.name

    expect(page).to have_css('h2', text: 'Mensalidades')
    expect(page).to have_content(registration.plan.value)
  end
end