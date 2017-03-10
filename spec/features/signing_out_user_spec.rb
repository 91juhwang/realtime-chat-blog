require 'rails_helper'

RSpec.feature 'Signing up users' do
  before do
    @user = User.create(email: 'abc@gmail.com', password: '123456')
    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: 'abc@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  scenario 'User signs out' do
    visit root_path
    click_link 'Sign out'
    
    expect(page).to have_content('Signed out successfully')
  end
end
