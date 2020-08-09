module ApplicationHelper
  def navbar_brand
    if current_user
      content_tag(:p, current_user.name, class: "navbar-brand disabled m-0 p-0")
    else
      content_tag(:p, 'Login/Signup', class: "navbar-brand disabled m-0 p-0")
    end
  end
end
