class Ticket < ActiveRecord::Base

  belongs_to :user
  has_many :comments

  attr_accessible :description, :subject, :ticket_type, :status

  def self.search(status)

    if status
      find(:all, :conditions => ['status LIKE ?', "%#{status}%"] )
    else
      find(:all)
    end
    
  end

end
