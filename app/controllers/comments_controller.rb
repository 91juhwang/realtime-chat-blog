class CommentsController < ApplicationController
  before_action :set_article
  before_action :redirect_if_not_current_user

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      ActionCable.server.broadcast "comments", 
        render(partial: 'comments/comment', object: @comment)
      flash[:notice] = 'Comment has been created'
    else
      flash[:alert] = 'Comment has not been created'
    end
  end

  private

  def redirect_if_not_current_user
    unless current_user
      flash[:alert] = "Please sign in or sign up first"
      redirect_to new_user_session_path
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end