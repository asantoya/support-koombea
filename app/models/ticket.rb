class Ticket < ActiveRecord::Base

  belongs_to :user
  has_many :comments

  include AASM

  attr_accessible :description, :subject, :ticket_type, :status, :user_id

  aasm :column => :status do 
    state :process, :initial => true
    state :approved
    state :ended
    state :pending

    event :approved do
      transitions :to => :approved, :from => [:process, :pending]
    end

    event :end do
      transitions :to => :ended, :from => [:approved, :pending]
    end

    event :pending do
      transitions :to => :pending, :from => [:process]
    end
  end

  def self.search(status)

    if status
      find(:all, :conditions => ['status LIKE ?', "%#{status}%"] )
    else
      find(:all)
    end
    
  end

  def display_name
    self.subject
  end


end
