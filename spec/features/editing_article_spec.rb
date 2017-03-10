require 'rails_helper'

RSpec.feature 'Editing an article' do
  before do
    @article = Article.create(title: 'Title', body: 'Ipsum Lorem')
    @user = User.create(email: 'abc@gmail.com', password: '123456')
    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: 'abc@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

  end

  scenario 'User edits an existing article' do
    visit root_path

    click_link @article.title
    click_link 'Edit Article'

    fill_in 'Title', with: 'Title edited'
    fill_in 'Body', with: 'Body edited'

    click_button 'Update Article'

    expect(page).to have_current_path(article_path(@article.id))
    expect(page).to have_content('Article has been edited')
  end

  scenario 'User edits an article with no contents' do
    visit root_path

    click_link @article.title
    click_link 'Edit Article'

    fill_in 'Title', with: ''
    fill_in 'Body', with: ''

    click_button 'Update Article'

    expect(page).to have_current_path(article_path(@article.id))
    expect(page).to have_content('Article has not been edited')
  end
end