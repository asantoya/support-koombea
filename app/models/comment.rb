class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  attr_accessible :body

  validates :body, presence: true

  after_create :mail_new_comment

  def mail_new_comment
    begin
      TicketMailer.new_comment(self).deliver    
    rescue => e
    end
  end
end
