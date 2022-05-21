module PostsHelper
  def available_communities
    current_user.communities.pluck(:name)
                            .concat(current_user.owned_communities.pluck(:name))
  end
end
