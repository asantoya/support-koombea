class Ticket < ActiveRecord::Base

  belongs_to :user
  has_many :comments

  attr_accessible :description, :subject, :ticket_type, :status, :user_id

  validates :subject, :description, :ticket_type, :status, :user_id, presence: true
  
  include AASM

  aasm :column => :status do 
    state :pending, :initial => true
    state :process
    state :ended
    state :approved
    state :rejected

    event :approve do
      transitions :to => :approved, :from => [:ended]
    end

    event :finish do
      transitions :to => :ended, :from => [:process]
    end

    event :process do
      transitions :to => :process, :from => [:pending,:rejected]
    end

    event :reject do
      transitions :to => :rejected, :from => [:ended]
    end

    event :pending do
      transitions :to => :pending, :from => [:rejected]
    end    
  end

  STATUS = [['Process', 'process'],['Ended', 'ended'],['Approved', 
             'approved'],['Pending', 'pending'],['Rejected','rejected']]

  def self.search(status)

    if status
      where(status: status).order("created_at DESC")
    else
      order("created_at DESC")
    end
  end

  def display_name
    self.subject
  end
end
