class CommentsController < ApplicationController

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.new(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @ticket.save
        @success = "The comment was saved successfully."
      else
        @error = "There was an error while saving the comment. Please, check the fields."
      end
      format.js
    end
  end

end
