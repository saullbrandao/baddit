module CommunitiesHelper
  def total_members(community)
    number_to_human community.users.count + 1, units: { thousand: 'k', million: 'm', billion: 'b' }
  end
end
