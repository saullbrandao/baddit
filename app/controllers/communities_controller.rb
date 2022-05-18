class CommunitiesController < ApplicationController
  def show
    @community = Community.find_by(slug: params[:slug])
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)

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
end
