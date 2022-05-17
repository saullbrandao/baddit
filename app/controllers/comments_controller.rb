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

  private

  def comment_params
    params.permit(:body)
  end
end
