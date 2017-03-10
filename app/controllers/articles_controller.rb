class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to articles_path, notice: 'Article has been created'
    else
      flash.now[:alert] = 'Article has not been created'
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article.id), notice: 'Article has been edited'
    else
      flash.now[:alert] = 'Article has not been edited'
      render :edit
    end
  end

  def destroy
    redirect_to articles_path, notice: 'Article has been deleted' if @article.destroy
  end

  private

  def resource_not_found
    redirect_to root_path, alert: 'The article you are looking could not be found'
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
