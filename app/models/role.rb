class Role < ActiveRecord::Base
  attr_accessible :role
  has_many :users

  def display_name
    self.name
  end
end
