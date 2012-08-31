ActiveAdmin.register Comment, :as => "TicketComment" do

  menu :label => "Comments", :parent => "Tickets"

  index do
    column :body do |comment|
      markdown comment.body
    end
    column "" do |ticket|
      links = link_to "View", admin_ticket_comment_path(ticket), :class => "member_link show_link"
      links += ''.html_safe
      links += ''.html_safe
      links
    end   
  end

  show do
    attributes_table do
      row :ticket
      row :user
      row :created_at
      row :body do |ticket|
        markdown ticket.body
      end
    end
  end
  
end
