class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :correct_user, only: [:destroy]

  def show
    @community = Community.find_by(slug: params[:slug])
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(name: community_params[:name], owner: current_user)

    if @community.save
      flash[:success] = "Community created!"
      redirect_to community_path(@community.slug)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @community = Community.find_by(slug: params[:slug])
    @community.destroy

    flash[:success] = "Community deleted!"
    redirect_to :root
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
