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
end
