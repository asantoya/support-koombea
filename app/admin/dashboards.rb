ActiveAdmin::Dashboards.build do

  section "Recent Tickets" do
    table_for Ticket.order("created_at desc").limit(10) do
      column :subject do |ticket|
        link_to ticket.subject, [:admin, ticket]
      end
      column :status
    end
    strong { link_to "View All Tickets", admin_tickets_path }
  end

end
