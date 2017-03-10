require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  before do
    @article = Article.create(title: 'Title', body: 'Ipsum Lorem')
  end

  describe 'GET /articles/:id' do
    context 'with exisiting article' do
      before { get "/articles/#{@article.id}" }

      it "should return status to have 200" do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existing article' do
      before { get "/articles/xxxx" }

      it "should return the status of 302" do
        expect(response.status).to eq 302
        flash_message = "The article you are looking could not be found"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
end