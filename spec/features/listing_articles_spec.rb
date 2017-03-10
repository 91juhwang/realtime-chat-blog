require 'rails_helper'

RSpec.feature 'Listing rescent articles' do
  before do
    @article1 = Article.create(title: 'Article 1', body: '11Lorem Ipsum')
    @article2 = Article.create(title: 'Article 2', body: '22Lorem Ipsum')
  end

  scenario 'A user sees rescent 2 articles' do
    visit '/'

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end

  scenario 'A user has no articles' do
    # because we created articles using before do block
    Article.delete_all
    visit '/'

    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within('h1#no-articles') do
      expect(page).to have_content('No Articles Created')
    end
  end
end
