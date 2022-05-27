module ApplicationHelper
  def vote_button_class(votable, vote)
    base_class = "hover:bg-gray-200 rounded"
    if current_user && current_user.voted_with?(votable, vote)
      "text-red-600 #{base_class}"
    else
      base_class
    end
  end

  def flash_class(level)
    base_class = "flex gap-2 animate-abc rounded-md border-1 border-gray-800 p-2 max-w-fit mx-auto z-10 absolute left-0 right-0 -top-8"
    case level
    when :notice then "bg-blue-100 text-blue-800 #{base_class}"
    when :success then "bg-green-100 text-green-800 #{base_class}"
    when :error then "bg-orange-100 text-orange-800 #{base_class}"
    when :alert then "bg-red-100 text-red-800 #{base_class}"
    end
  end
end
