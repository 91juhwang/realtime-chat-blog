require 'rails_helper'

RSpec.feature 'Editing an article' do
  before do
    @user = User.create(email: 'abc@gmail.com', password: '123456')
    @user2 = User.create(email: 'abcdef@gmail.com', password: '123456')
    @article = Article.create(title: 'Title1', body: 'Ipsum Lorem', user: @user)
  end

  scenario 'Article owner edits an existing article' do
    login_as(@user)
    visit root_path

    click_link @article.title
    click_link 'Edit Article'

    fill_in 'Title', with: 'Title edited'
    fill_in 'Body', with: 'Body edited'

    click_button 'Update Article'

    expect(page).to have_current_path(article_path(@article.id))
    expect(page).to have_content('Article has been edited')
  end

  scenario 'Article owner edits an article with no contents' do
    login_as @user
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