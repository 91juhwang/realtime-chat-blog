require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  before do
    @user = User.create(email: '123@abc.com', password: '123456')
    @user2 = User.create(email: '12345@abc.com', password: '123456')
    @article = Article.create!(title: 'Title', body: 'Ipsum Lorem', user: @user)
  end

  describe 'GET /articles/:id/edit' do
    context 'with non-sigend-in user' do
      before { get "/articles/#{@article.id}/edit" }

      it 'should redirect to the sign-in page' do
        expect(response.status).to eq 302
        msg = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq msg
      end
    end

    context 'with signed-in non-owner user' do
      before do
        login_as @user2
        get "/articles/#{@article.id}/edit"
      end

      it 'should redirect to the root page' do
        expect(response.status).to eq 302
        msg = 'You can only edit your own articles.'
        expect(flash[:alert]).to eq msg
      end
    end
  end

  describe 'GET /articles/:id' do
    context 'with sigined_in owner user' do
      before do
        login_as @user
        get "/articles/#{@article.id}"
      end

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