ActiveAdmin.register Comment, :as => "TicketComment" do

  menu :label => "Comments", :parent => "Tickets"

  index do
    column :body do |comment|
      noHtmlTags comment.body
    end    
  end
  
end
