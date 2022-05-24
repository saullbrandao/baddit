class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def create
    @post = Post.find_by(slug: params[:post_slug])
    @comment = @post.comments.new(body: comment_params[:body], user: current_user)

    if @comment.save
      flash[:success] = "Comment created successfully"
      redirect_to community_post_path(slug: @comment.post.slug)
    else
      flash[:error] = "Comment could not be created"
      redirect_to request.referrer
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    flash[:success] = "Comment deleted successfully"
    redirect_to posts_path(slug: @comment.post.slug)
  end

  def upvote 
    @comment = Comment.find_by(id: params[:comment_id])
    Vote.upvote(current_user, @comment)
    
    flash[:error] = "Error while saving vote" unless @comment.save

    redirect_back(fallback_location: root_path)
  end

  def downvote 
    @comment = Comment.find_by(id: params[:comment_id])
    Vote.downvote(current_user, @comment)
    
    flash[:error] = "Error while saving vote" unless @comment.save

    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.permit(:body)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to :root unless @comment
  end
end
