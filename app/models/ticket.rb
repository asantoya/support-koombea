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

  after_create :mail_new_ticket
  before_save :check_assigned
  after_update :mail_to_assigned

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

  def check_assigned
    self.assigned_to_id = 0 if self.assigned_to_id.blank?
  end

  def mail_to_assigned
    TicketMailer.assigned_to(self).deliver if self.assigned_to_id_changed? && self.assigned_to.present?
  end

  def self.mail_status_change(ticket, user)
    binding.pry
    @user_mail =  ticket.user.email if  ticket.status == "ended" 
    @user_mail =  ticket.assigned_to.email if  ticket.status == "approved" ||  ticket.status == "rejected"
    unless  ticket.status == "pending" ||  ticket.status == "in_process"
      TicketMailer.state_change(ticket, user, @user_mail).deliver if ticket.assigned_to.present?
    end     
  end
end
