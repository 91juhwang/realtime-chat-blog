require 'rails_helper'

RSpec.feature 'Showing an article' do
  before do
    @article = Article.create(title: 'title1', body: 'Ipsum Lorem')
    @user = User.create(email: 'abc@gmail.com', password: '123456')
    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: 'abc@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end
  
  scenario 'A user sees a selected article' do
    visit root_path
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page.current_path).to eq(article_path(@article.id))
  end
end
