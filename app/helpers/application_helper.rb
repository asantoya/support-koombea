module ApplicationHelper

  def toHtmlSafe(text)
    text.html_safe
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(
                                        :hard_wrap => true, :safe_links_only => true),
                :no_intraemphasis => true, :autolink => true, :space_after_headers => true)
    
    return markdown.render(text).html_safe
  end

end
