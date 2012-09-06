class TicketsController < ApplicationController

  def index
    if current_user.role == "support"
      @tickets = Ticket.search(params[:status])
    else 
      @tickets = current_user.tickets.search(params[:status])
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
        if @ticket.blank?
          flash[:error] = "Sorry, ticket is not accessible. Access is denied."
          redirect_to tickets_path
        end
        } 
      format.json { render json: @ticket }
    end
  end

  def new
    @ticket = Ticket.new
    @clients = User.where(role: "client")
    @user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end

  def edit
    @user = current_user
    @clients = User.where(role: "client")

    if current_user.role == "support"
      @ticket = Ticket.find_by_id(params[:id])  
    else
      @ticket = current_user.tickets.find_by_id(params[:id])
    end

    if @ticket.blank?
      flash[:error] = "Sorry, ticket is not accessible. Access is denied."
      redirect_to tickets_path
    end
    
  end

  def create   
    @clients = User.where(role: "client")
    
    if current_user.role == "support"
      @ticket = Ticket.new(params[:ticket])
    else
      @ticket = current_user.tickets.build(params[:ticket])      
    end
    
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = current_user
    authorize! :choose_client, @user if params[:ticket][:choose_client]

    @ticket = Ticket.find(params[:id])
    begin
      case params[:ticket][:status]
        when 'ended'
          @ticket.finish!
        when 'rejected'
          @ticket.reject!
        when 'process'
          @ticket.process!
        when 'approved'
          @ticket.approve!
        when 'pending'
          @ticket.pending!
      end
      params[:ticket].delete(:status)
      if @ticket.update_attributes(params[:ticket])
        redirect_to tickets_path, notice: 'Ticket was successfully updated.'
      end
    rescue AASM::InvalidTransition
      flash[:alert] = "You cann't select this state"
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
