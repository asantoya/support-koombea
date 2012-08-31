class Role < ActiveRecord::Base
  attr_accessible :name
  has_many :users

  validates :name, presence: true

  def display_name
    self.name
  end
end
