module ApplicationHelper
  def vote_button_class(votable, type, vote)
    if current_user && current_user.voted_with?(votable, type, vote)
      "text-red-600"
    else
      ""
    end
  end
end
