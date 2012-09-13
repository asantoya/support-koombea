class TicketMailer < ActionMailer::Base

  default from: "contact@koombea.com"

  def new_ticket(ticket)
    @users = User.where(role: "support", receives_notifications: true).pluck(:email).join(",")

    @ticket = ticket

    mail(to: @users, subject: "New Ticket created")
  end

  def new_comment(comment)
    @comment = comment
    @users = [@comment.ticket.assigned_to.email, @comment.ticket.user.email ].join(",")

    mail(to: @users, subject: "New Comment")
  end

  def state_change(ticket, user)
    @ticket = ticket
    @user = user
    @users_mail = [@ticket.user.email, @ticket.assigned_to.email]
  
    mail(to: @users_mail, subject: "State change in a ticket")
  end
end
