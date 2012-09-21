class Document < ActiveRecord::Base
  belongs_to :comment
  attr_accessible :document
  
  include Rails.application.routes.url_helpers
  mount_uploader :document, DocumentUploader 
end
