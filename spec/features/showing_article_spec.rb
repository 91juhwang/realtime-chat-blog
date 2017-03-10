require 'rails_helper'

RSpec.feature 'Showing an article' do
  before do
    @article = Article.create(title: 'title1', body: 'Ipsum Lorem')
  end
  
  scenario 'A user sees a selected article' do
    visit root_path
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page.current_path).to eq(article_path(@article.id))
  end
end
