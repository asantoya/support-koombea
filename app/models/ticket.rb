class Ticket < ActiveRecord::Base

  belongs_to :user
  belongs_to :assigned_to, class_name: 'User'
  has_many :comments, :dependent => :destroy

  attr_accessible :description, :subject, :ticket_type, :status, :user_id, :assigned_to_id

  validates :subject, presence: true
  validates :description, presence: true
  validates :ticket_type, presence: true
  validates :status, presence: true
  validates :user_id, presence: { message: "Client can't be blank" }
  
  include AASM

  aasm :column => :status do 
    state :pending, :initial => true
    state :in_process
    state :ended
    state :approved
    state :rejected

    event :approve do
      transitions :to => :approved, :from => [:ended]
    end

    event :finish do
      transitions :to => :ended, :from => [:in_process]
    end

    event :process do
      transitions :to => :in_process, :from => [:pending,:rejected]
    end

    event :reject do
      transitions :to => :rejected, :from => [:ended]
    end

    event :pending do
      transitions :to => :pending, :from => [:rejected,:in_process]
    end    
  end

  STATUS = [['Pending', 'pending'],['In Process', 'in_process'],['Ended', 'ended'],
            ['Approved','approved'],['Rejected','rejected']]

  TYPE = [['Bug','bug'],['Features', 'features']]

  ASSIGNED = User.where(role: "support")

  CLIENTS = User.where(role: "client")
  
  after_create :mail_new_ticket

  def self.search(client, assigned, status)
    tickets = order("created_at DESC").includes(:user).includes(:comments)
    tickets = tickets.where(user_id: client) if client.present?
    tickets = tickets.where(assigned_to_id: assigned) if assigned.present?
    tickets = tickets.where(status: status) if status.present?
    tickets
  end

  def display_name
    self.subject
  end

  def mail_new_ticket
    @users = User.where(role: "support", receives_notifications: true).pluck(:email).join(",")
    if @users.present?
      TicketMailer.new_ticket(self, @users).deliver
    end
  end
end
