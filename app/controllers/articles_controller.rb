class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = 'Article has been created'
      redirect_to articles_path
    else
      flash.now[:alert] = 'Article has not been created'
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = 'Article has been edited'
      redirect_to article_path(@article.id)
    else
      flash.now[:alert] = 'Article has not been edited'
      render :edit
    end
  end

  private

  def resource_not_found
    message = 'The article you are looking could not be found'
    flash[:alert] = message
    redirect_to root_path
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
