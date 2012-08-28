class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  attr_accessible :body
end
