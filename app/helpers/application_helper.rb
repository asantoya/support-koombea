module ApplicationHelper

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(
                                        :hard_wrap => true, :safe_links_only => true),
                :no_intraemphasis => true, :autolink => true, :space_after_headers => true)
    
    return markdown.render(text).html_safe
  end

  def avatar_url(user)
    default_url = "#{root_url}assets/img.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?d=#{CGI.escape(default_url)}"
  end

end
