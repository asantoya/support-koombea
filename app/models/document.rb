class Document < ActiveRecord::Base
  belongs_to :comment
  attr_accessible :document
  
  include Rails.application.routes.url_helpers
  mount_uploader :document, DocumentUploader 

  def icon_extension
    case self.document.file.extension
      when "jpg", "jpeg", "png", "gif"
        icon_class = "img"
      when "doc", "docx", "odt"
        icon_class = "doc"
      when "xls", "xlsx", "ods"
        icon_class = "xls"
      when "pdf"
        icon_class = "pdf"
      else
        icon_class = "mul"
    end
  end
end
