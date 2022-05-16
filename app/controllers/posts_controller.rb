class PostsController < ApplicationController
  def index
    @posts = Post.all.order(total_votes: :desc)
  end

  def show
    @post = Post.find_by(slug: params[:slug])
    @community = @post.community
  end

  def new
    @post = Post.new
  end

  def create 
    @post = current_community.posts.build(title: post_params[:title], 
                                          body: post_params[:body])

    if @post.save
      redirect_to community_post_path(@community.slug, @post.slug), 
                                success: "Post created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :community)
  end

  def current_community
    @community = Community.find_by(slug: post_params[:community])
  end
end
