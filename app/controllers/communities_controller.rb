class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :paginate]
  before_action :correct_user, only: [:destroy]

  def show
    @community = Community.find_by(slug: params[:slug])
    @pagy, @posts = pagy(@community.posts.order(created_at: :desc), items: 10)
  end
  
  def paginate
    @community = Community.find_by(slug: params[:community_slug])
    @pagy, @posts = pagy(@community.posts.order(created_at: :desc), items: 10)

    respond_to do |format|
      format.turbo_stream
    end
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(name: community_params[:name], owner: current_user)

    if @community.save
      flash[:success] = "Community created successfully!"
      redirect_to community_path(@community.slug)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @community = Community.find_by(slug: params[:slug])
    @community.destroy

    flash[:success] = "Community deleted successfully!"
    redirect_to :root
  end

  def join
    @community = Community.find_by(slug: params[:community_slug])
    current_user.join(@community)

    flash[:success] = "You have joined the community!"
    redirect_to community_path(@community.slug)
  end

  def leave
    @community = Community.find_by(slug: params[:community_slug])
    current_user.leave(@community)

    flash[:success] = "You have left the community!"
    redirect_to community_path(@community.slug)
  end

  private

  def community_params
    params.require(:community).permit(:name)
  end

  def correct_user
    @community = current_user.owned_communities.find_by(slug: params[:slug])
    redirect_to :root unless @community
  end 
end
