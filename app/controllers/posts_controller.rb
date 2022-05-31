class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

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
        flash[:success] = "Post created successfully!"
        redirect_to community_post_path(@community.slug, @post.slug)
      else
        render :new, status: :unprocessable_entity
      end

    else
      flash[:error] = "You are not allowed to post in this community!"
      redirect_to :root
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(title: post_params[:title], body: post_params[:body])
      flash[:success] = "Post updated successfully!"
      redirect_to community_post_path(@post.community.slug, @post.slug)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    flash[:success] = "Post deleted successfully!"
    redirect_to :root
  end

  def upvote 
    @post = Post.find_by(id: params[:post_id])
    Vote.upvote(current_user, @post)
    
    flash[:error] = "Error while saving vote!" unless @post.save
    
    redirect_back(fallback_location: root_path)
  end
  
  def downvote 
    @post = Post.find_by(id: params[:post_id])
    Vote.downvote(current_user, @post)
    
    flash[:error] = "Error while saving vote!" unless @post.save

    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :community)
  end

  def current_community
    @community = Community.find_by(slug: post_params[:community])
  end

  def correct_user
    @user = Post.find(params[:id]).user

    unless @user == current_user
      flash[:error] = "You are not allowed to do this action!"
      redirect_to :root 
    end
  end

  def can_post?
    current_community.users.include?(current_user) || current_user.owns?(current_community)
  end
end
