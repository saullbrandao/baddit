class CommunitiesController < ApplicationController
  def show
    @community = Community.find_by(slug: params[:slug])
  end
end
