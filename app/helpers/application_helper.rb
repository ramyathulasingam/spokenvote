module ApplicationHelper
  def fb_button(btn_text)
  	content_tag(:span, '', class: "fb-button-left") +
  	content_tag(:span, content_tag(:strong, btn_text) + ' with ' + content_tag(:strong, 'Facebook'), class: "fb-button-center") +
  	content_tag(:span, '', class: "fb-button-right")
  end

  def items_count_badge(items, title_text = '')
    badge_class = 'badge'
    if items.between?(3,5)
      badge_class += ' badge-inverse'
    elsif items.between?(6,8)
      badge_class += ' badge-info'
    elsif items > 8
      badge_class += ' badge-success'
    end
    if title_text == ''
      content_tag(:div, items, :class => badge_class)
    else
      content_tag(:div, items, :class => badge_class, :title => title_text, :rel => 'tooltip')
    end
  end

  def current_user_link
    if user_signed_in?
      link_to current_user.username || current_user.email, proposals_path(user_id: current_user.id)
    else
      content_tag(:span, 'Unknown')
    end
  end
  #
  #def current_user_voteable?(proposal)                   # Moved to Proposals controller for json packaging in RABL
  #  if current_user && current_user.id == proposal.user_id
  #    cu_votes = proposal.votes.count {|v| v.user_id == current_user.id}
  #  end
  #  return cu_votes.present?
  #end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end
  
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def get_default_avatar_image
    the_root_url = request.host == 'localhost' ? 'http://www.spokenvote.com/' : root_url    
    the_root_url + DEFAULT_AVATAR_URL
  end
end
