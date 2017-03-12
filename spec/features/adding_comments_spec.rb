require 'rails_helper'

RSpec.feature 'Adding reviews to articles' do
  before do
    @user = User.create(email: 'abc@abc.com', password: '123456')
    @user2 = User.create(email: 'abdefc@abc.com', password: '123456')
    @article = Article.create(title: 'Article 2', body: '22Lorem Ipsum', user: @user)
  end

  scenario 'Signed in user writes a review to an article' do
    login_as @user2
    visit root_path

    click_link @article.title
    fill_in 'New Comment', with: 'this is a comment'
    click_button 'Add Comment'

    expect(page).to have_content('Comment has been added')
    expect(page).to have_content('this is a comment')
    expect(page).to have_current_path(article_page(@article.id))
  end
end