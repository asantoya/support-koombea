class TicketMailer < ActionMailer::Base

  @users = User.where(role: "support", receives_notifications: true).pluck(:email).join(",")

  ap @users

  default from: "contact@koombea.com",
          to: @users

  def new_ticket(ticket)
    @ticket = ticket

    mail(subject: "New Ticket created")
  end
end
