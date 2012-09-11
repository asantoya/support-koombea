class TicketMailer < ActionMailer::Base

  default from: "contact@koombea.com"

  def new_ticket(ticket)
    @users = User.where(role: "support", receives_notifications: true).pluck(:email).join(",")

    @ticket = ticket

    mail(to: @users, subject: "New Ticket created")
  end

  def new_comment(comment)
    @users = User.where(role: "support", receives_notifications: true).pluck(:email).join(",")
    @comment = comment

    mail(to: @users, subject: "New Comment")
  end
end
