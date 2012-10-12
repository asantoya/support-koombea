require 'carrierwave/test/matchers'

describe DocumentUploader do
  include CarrierWave::Test::Matchers

  before do
    DocumentUploader.enable_processing = true
    @uploader = DocumentUploader.new(@user, :document)
    @uploader.store!(File.open(Rails.root, 'public', 'test', 'colombia.jpeg'))
  end

  after do
    DocumentUploader.enable_processing = false
    @uploader.remove!
  end

end