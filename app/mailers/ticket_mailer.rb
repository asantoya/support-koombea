class TicketMailer < ActionMailer::Base

  default from: "contact@koombea.com"

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

  def state_change(ticket, user)
    @ticket = ticket
    @user = user
    
    @users_mail = [@ticket.user.email]
    @users_mail << @ticket.assigned_to.email if @ticket.assigned_to.present?
  
    mail(to: @users_mail, subject: "Ksupport - State change in a ticket")
  end

  def assigned_to(ticket)
    @ticket = ticket
    @user = ticket.assigned_to.email
    mail(to: @user, subject: "Ksupport - Assigned to")
  end
end
