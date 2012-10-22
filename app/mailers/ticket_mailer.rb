class TicketMailer < ActionMailer::Base

  default from: "Koombea Support <support@koombea.com>"

  def new_ticket(ticket, users)
    @users = users
    @ticket = ticket
    @url_ticket = edit_ticket_url(@ticket)
    @url = root_url
    mail(to: @users, subject: "Ksupport - New Ticket created: #{@ticket.subject}")
  end

  def new_comment(comment)
    @comment = comment
    @users = [@comment.ticket.user.email]
    @users << @comment.ticket.assigned_to.email if @comment.ticket.assigned_to.present?
    @url_ticket = edit_ticket_url(@comment.ticket)
    @url = root_url
    mail(to: @users, subject: "Ksupport - New Comment: #{@comment.ticket.subject}")
  end

  def state_change(ticket, user, user_mail)
    @ticket = ticket
    @user = user
    @user_mail = user_mail
    @url_ticket = edit_ticket_url(@ticket)
    @url = root_url
    mail(to: @user_mail, subject: "Ksupport - Status change in a ticket: #{@ticket.subject}")
  end

  def assigned_to(ticket)
    @ticket = ticket
    @user = ticket.assigned_to
    @url_ticket = edit_ticket_url(@ticket)
    @url = root_url
    mail(to: @user.email, subject: "Ksupport - Assigned to the ticket: #{@ticket.subject}")
  end

  def new_user(user)
    @user = user
    @url = root_url
    mail(to: @user.email, subject: "Ksupport - Welcome")
  end
end
