class TicketsController < ApplicationController

  def index
    @user = current_user
    @assigned = User.where(role: "support")
    @clients = User.where(role: "client")

    if current_user.role == "support"
      @tickets = Ticket.search(params[:user_id], params[:assigned_to_id], params[:status]).paginate(:page => params[:page], :per_page => 10)
    else 
      @tickets = current_user.tickets.search(nil, nil, params[:status]).paginate(:page => params[:page], :per_page => 10)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
      format.js
    end
  end

  def show
    if current_user.role == "support"   
      @ticket = Ticket.find_by_id(params[:id])  
    else
      @ticket = current_user.tickets.find_by_id(params[:id])
    end
    
    respond_to do |format|
      format.html {
        if @ticket.present?
          redirect_to edit_ticket_path(@ticket)
        else
          flash[:error] = "Sorry, ticket is not accessible. Access is denied."
          redirect_to tickets_path
        end
      } 
    end
  end

  def new
    @ticket = Ticket.new
    @clients = User.where(role: "client")
    @assigned = User.where(role: "support")
    @user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end

  def edit
    @user = current_user
    @clients = User.where(role: "client")
    @assigned = User.where(role: "support")
    
    if current_user.role == "support"
      @ticket = Ticket.includes(:user).includes(:comments).find_by_id(params[:id])  
    else
      @ticket = current_user.tickets.includes(:user).includes(:comments).find_by_id(params[:id])
    end

    if @ticket.present?
      @comments = @ticket.comments
      @count_comments = @ticket.comments.unread_by(@user).count
    else
      flash[:error] = "Sorry, ticket is not accessible. Access denied."
      redirect_to tickets_path
    end
  end

  def create 
    if current_user.role == "support"
      @ticket = Ticket.new(params[:ticket])
    else
      @ticket = current_user.tickets.build(params[:ticket])      
    end

    respond_to do |format|
      if @ticket.save
        TicketMailer.assigned_to(@ticket).deliver if @ticket.assigned_to.present?
        format.html { redirect_to edit_ticket_path(@ticket), notice: 'Ticket was successfully created.' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { 
          @clients = User.where(role: "client")
          @assigned = User.where(role: "support")
          @user = current_user
          render action: "new" 
        }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = current_user
    @ticket = Ticket.find(params[:id])

    unless params[:ticket][:status] == @ticket.status 
      unless params[:ticket][:assigned_to_id].present?
        flash[:alert] = "The ticket hasn't been assigned, you can't change the status"
        redirect_to edit_ticket_path(@ticket)
        return
      end
    end

    begin
      unless params[:ticket][:status] == @ticket.status
        case params[:ticket][:status]
          when 'ended'
            @ticket.finish!
          when 'rejected'
            @ticket.reject!
          when 'in_process'
            @ticket.process!
          when 'approved'
            @ticket.approve!
          when 'pending'
            @ticket.pending!
        end
        params[:ticket].delete(:status)
      end

      @ticket.assigned_to_id = params[:ticket][:assigned_to_id]
      assigned_changed = @ticket.assigned_to_id_changed?

      if @ticket.update_attributes(params[:ticket])
        TicketMailer.assigned_to(@ticket).deliver if assigned_changed == true && @ticket.assigned_to.present?
        unless params[:ticket][:status] == @ticket.status
          unless @ticket.status == "pending" || @ticket.status == "in_process"
            @user_mail = @ticket.user.email if @ticket.status == "ended"
            @user_mail = @ticket.assigned_to.email if @ticket.status == "approved" || @ticket.status == "rejected"
            TicketMailer.state_change(@ticket, @user, @user_mail).deliver   
          end
        end
        redirect_to edit_ticket_path(@ticket), notice: 'Ticket was successfully updated.'
      end
    rescue AASM::InvalidTransition
      flash[:alert] = "You can't select this state"
      redirect_to edit_ticket_path(@ticket)
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end
end
