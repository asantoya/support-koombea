class CommentsController < ApplicationController

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.new(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @ticket.save
        format.js
      else
        redirect_to tickets_path
      end
    end

  end
  
end
