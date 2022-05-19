class CommentsController < ApplicationController
  def create
    @post = Post.find_by(slug: params[:post_slug])
    @comment = @post.comments.new(comment_params)

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

  private

  def comment_params
    params.permit(:body)
  end
end
