class TicketMailer < ActionMailer::Base

  default from: "support@koombea.com"

  def new_ticket(ticket, users)
    @users = users
    @ticket = ticket
    mail(to: @users, subject: "Ksupport - New Ticket created")

  end

  def new_comment(comment)
    @comment = comment

    @users = [@comment.ticket.user.email]
    @users << @comment.ticket.assigned_to.email if @comment.ticket.assigned_to.present?
    
    mail(to: @users, subject: "Ksupport - New Comment")
  end

  def state_change(ticket, user, user_mail)
    @ticket = ticket
    @user = user
    @user_mail = user_mail
    
    mail(to: @user_mail, subject: "Ksupport - State change in a ticket")
  end

  def assigned_to(ticket)
    @ticket = ticket
    @user = ticket.assigned_to.email
    mail(to: @user, subject: "Ksupport - Assigned to a new ticket")
  end

  def new_user(user)
    @user = user
    @url = root_url
    mail(to: @user.email, subject: "Ksupport - Welcome")
  end
end
