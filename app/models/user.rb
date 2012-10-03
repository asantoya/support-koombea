class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :registerable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :receives_notifications
  # attr_accessible :title, :body

  has_many :tickets
  has_many :assigned_tickets, foreign_key: 'assigned_to_id', class_name: 'Ticket'
  has_many :comments, :dependent => :destroy

  devise :omniauthable

  after_create :mail_new_user

  def display_name
    self.email
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
