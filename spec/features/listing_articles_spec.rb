require 'rails_helper'

RSpec.feature 'Listing rescent articles' do
  before do
    @user = User.create(email: 'abc@abc.com', password: '123456')
    @article1 = Article.create(title: 'Article 1', body: '11Lorem Ipsum', user: @user)
    @article2 = Article.create(title: 'Article 2', body: '22Lorem Ipsum', user: @user)
  end

  scenario 'User not signed in and visits the root' do
    visit '/'

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).not_to have_link("New Article")
  end

  scenario 'A user is not signed in and visits the root' do
    # because we created articles using before do block
    Article.delete_all
    visit '/'

    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)
    expect(page).to have_link("Sign in")
    expect(page).to have_link("Sign up")

    within('h1#no-articles') do
      expect(page).to have_content('No Articles Created')
    end
  end
end
