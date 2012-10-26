ActiveAdmin.register Ticket do

  config.per_page = 10

  index do
    column :subject
    column :updated_at do |t|
      t.updated_at.strftime("%b %e, %Y")
    end
    column "Status", :status
    column "Type", :ticket_type do |t|
      t.ticket_type.capitalize
    end
    column :assigned_to do |t|
      t.assigned_to.name if t.assigned_to.present?
    end

    default_actions 
  end

  filter :user, label: "Client", collection: User.where(role: "client")
  filter :assigned_to, collection: User.where(role: "support")

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
      row :assigned_to
    end
  end

  form do |f|
    f.inputs "Tickets" do
      f.input :user, collection: User.where(role: "client")
      f.input :subject
      f.input :description 
      f.input :status, :as => :select, :collection => Ticket::STATUS
      f.input :ticket_type, :as => :select, :collection => Ticket::TYPE
      f.input :assigned_to, collection: User.where(role: "support")
    end

    f.buttons
  end

end
