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

  def mark_read_comments
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.comments.each do |c|
      c.mark_as_read! :for => current_user
    end
    respond_to do |format|
      format.js
    end
  end

end
