class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.build(body: params[:body], user: current_user)
    
    if @comment.save
      flash[:success] = "Comment created successfully!"
      redirect_to community_post_path(@post.community.slug, @post.slug)
    else
      flash[:error] = "Comment could not be created!"
      redirect_to @post
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      flash[:success] = "Comment updated successfully!"
    else
      flash[:error] = "Comment could not be updated!"
    end

    redirect_to community_post_path(@comment.post.community.slug, @comment.post.slug)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    flash[:success] = "Comment deleted successfully!"
    redirect_to posts_path(slug: @comment.post.slug)
  end

  def upvote 
    @comment = Comment.find_by(id: params[:comment_id])
    Vote.upvote(current_user, @comment)
    
    flash[:error] = "Error while saving vote!" unless @comment.save

    redirect_back(fallback_location: root_path)
  end

  def downvote 
    @comment = Comment.find_by(id: params[:comment_id])
    Vote.downvote(current_user, @comment)
    
    flash[:error] = "Error while saving vote!" unless @comment.save

    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to :root unless @comment
  end
end
