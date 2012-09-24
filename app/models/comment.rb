class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  has_many :documents, dependent: :destroy
  
  accepts_nested_attributes_for :documents
  attr_accessible :body, :documents_attributes

  validates :body, presence: true

  after_create :mail_new_comment

  def mail_new_comment
    begin
      TicketMailer.new_comment(self).deliver    
    rescue => e
    end
  end
end
