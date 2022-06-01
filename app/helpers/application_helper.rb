module ApplicationHelper
  def vote_button_class(votable, vote)
    base_class = "hover:bg-gray-200 rounded dark:hover:text-black"
    if current_user && current_user.voted_with?(votable, vote)
      "text-red-600 #{base_class}"
    else
      base_class
    end
  end

  def flash_class(level)
    base_class = "flex gap-2 animate-fade rounded-md border-1 border-gray-800 p-2 max-w-fit mx-auto z-50 absolute left-0 right-0 top-6 "
    case level
    when :notice then "bg-blue-100 text-blue-800 #{base_class}"
    when :success then "bg-green-100 text-green-800 #{base_class}"
    when :error, :alert then "bg-red-100 text-red-800 #{base_class}"
    end
  end
end
