require 'rails_helper'

RSpec.feature 'Showing an article' do
  before do
    @user = User.create(email: 'abc@gmail.com', password: '123456')
    @user2 = User.create(email: 'abcde@gmail.com', password: '123456')
    @article = Article.create(title: 'title1', body: 'Ipsum Lorem', user: @user)
  end
  
  scenario 'User is not signed in and is not able to see the show page' do
    visit root_path
    click_link @article.title

    expect(page).to have_content('You need to sign in or sign up before continuing.')
    expect(page).to have_button('Log in')
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'Hide edit and delete button to non-owner user' do
    login_as @user2
    visit root_path

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article.id))
    expect(page).not_to have_link('Edit Article')
    expect(page).not_to have_link('Delete Article')
  end

  scenario 'Display edit and delete button to the article owner' do
    login_as @user
    visit root_path

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article.id))
    expect(page).to have_link('Edit Article')
    expect(page).to have_link('Delete Article')
  end
end
