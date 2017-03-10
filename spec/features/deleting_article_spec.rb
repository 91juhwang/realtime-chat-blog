require 'rails_helper'

RSpec.feature 'Deleting an article' do
  before do
    @article = Article.create(title: 'Title1', body: 'Ipsum Lorem')
    @user = User.create(email: 'abc@gmail.com', password: '123456')
    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: 'abc@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  scenario 'User deletes an article' do
    visit root_path

    click_link @article.title
    click_link 'Delete Article'

    expect(page).to have_current_path(articles_path)
    expect(page).to have_content('Article has been deleted')
  end
end
