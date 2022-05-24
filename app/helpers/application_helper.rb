module ApplicationHelper
  def vote_button_class(votable, vote)
    if current_user && current_user.voted_with?(votable, vote)
      "text-red-600"
    else
      ""
    end
  end
end
