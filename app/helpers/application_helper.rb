module ApplicationHelper

  def noHtmlTags(text)
    text.html_safe
  end

end
