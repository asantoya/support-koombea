class CommentsController < ApplicationController

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.new(params[:comment])
    @comment.user = current_user

    if @ticket.save
      @success = "The comment was saved successfully."
    else
      @error = "There was an error while saving the comment. Please, check the fields."
    end

    respond_to do |format|
      format.js
    end
  end

end
