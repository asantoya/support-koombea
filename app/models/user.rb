class User < ActiveRecord::Base

  acts_as_reader
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :registerable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, 
                  :remember_me, :role, :receives_notifications, :name

  validates :name, :email, :role, presence: true                  

  has_many :tickets, :dependent => :destroy
  has_many :assigned_tickets, foreign_key: 'assigned_to_id', class_name: 'Ticket'
  has_many :comments, :dependent => :destroy

  after_create :mail_new_user

  def display_name
    self.name
  end

  def password_required?
    (!password.blank?) && super
  end

  def mail_new_user
    TicketMailer.new_user(self).deliver
  end

  class << self
    
    def find_for_google_apps(auth)
      user = find_or_initialize_by_email(auth["info"]["email"])
    end
  end

end
