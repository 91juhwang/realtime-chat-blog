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
    redirect_to new_user_session_path, alert: 'Please sign in or sign up first' unless current_user
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to articles_path, notice: 'Article has been created'
    else
      flash.now[:alert] = 'Article has not been created'
      render :new
    end
  end

  def show
    @comment = @article.comments.build
    @comments = @article.comments
  end

  def edit
    redirect_to root_path, alert: 'You can only edit your own articles.' unless @article.user == current_user
  end

  def update
    redirect_to root_path, alert: 'You can only edit your own articles.' unless @article.user == current_user
    if @article.update(article_params)
      redirect_to article_path(@article.id), notice: 'Article has been edited'
    else
      flash.now[:alert] = 'Article has not been edited'
      render :edit
    end
  end

  def destroy
    redirect_to root_path, alert: 'You can only delete your own articles.' unless @article.user == current_user
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
