ActiveAdmin.register Ticket do

  index do
    column :subject
    column :updated_at
    column "Status", :status
    column :ticket_type do |ticket|
      ticket.ticket_type.capitalize
    end

    default_actions 
  end

  filter :user, :title => :display_name

  show do
    attributes_table do
      row :subject
      row :description do |ticket|
        markdown ticket.description
      end
      row :created_at
      row :updated_at
      row :status do |ticket|
        ticket.status.capitalize
      end
      row :ticket_type do |ticket|
        ticket.ticket_type.capitalize
      end
      row :user
    end
  end

  form do |f|
    f.inputs "Tickets" do
      f.input :user
      f.input :subject
      f.input :description 
      f.input :status, :as => :select, :collection => [['Process', 'process'],['Ended', 'ended'],['Approved', 'approved'],['Pending', 'pending']]
      f.input :ticket_type, :as => :select, :collection => [['Bug', 'bug'], ['Features', 'features']]
    end

    f.buttons
  end

end
