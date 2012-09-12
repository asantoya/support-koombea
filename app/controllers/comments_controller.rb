class CommentsController < ApplicationController

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.new(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @ticket.save

        TicketMailer.new_comment(@comment).deliver 

        format.js
      else
        flash[:error] = "The comment could not be saved, please try again."
        redirect_to tickets_path
      end
    end

  end
  
end
