require 'rails_helper'

RSpec.feature 'Signing up users' do
  before do
    @user = User.create(email: 'abc@gmail.com', password: '123456')
  end
  scenario 'User signs up with valid information' do
    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
  end

  scenario "with invalid credentials" do
    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: ''
    fill_in 'Password', with: '@user.password'
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password.')
  end
end
