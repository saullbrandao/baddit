class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:destroy]

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
    if can_post?
      @post = current_community.posts.build(title: post_params[:title], 
                                            body: post_params[:body],
                                            user: current_user)
  
      if @post.save
        redirect_to community_post_path(@community.slug, @post.slug), 
                                  success: "Post created successfully"
      else
        render :new, status: :unprocessable_entity
      end

    else
      flash[:error] = "You are not allowed to post in this community"
      redirect_to :root
    end
  end

  def destroy
    @post = Post.find_by(slug: params[:slug])

    @post.destroy

    flash[:success] = "Post deleted successfully"
    redirect_to :root
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :community)
  end

  def current_community
    @community = Community.find_by(slug: post_params[:community])
  end

  def correct_user
    @post = current_user.posts.find_by(slug: params[:slug])
    redirect_to :root unless @post
  end

  def can_post?
    current_community.users.include?(current_user) || current_user.owns?(current_community)
  end
end
