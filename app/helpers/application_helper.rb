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

  def link_to_add_input_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn btn-mini btn-success", data: {id: id, fields: fields.gsub("\n", "")})
  end

end
