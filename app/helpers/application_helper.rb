module ApplicationHelper

  # Returns dynamic title for differing pages.
  def full_title(page_title = '')
    base_title = "Valhalla"
    if page_title.empty?
      base_title
    else
      base_title + " | " + page_title
    end
  end
end
