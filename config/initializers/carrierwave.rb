CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAI6IQHCHSVYNO253Q',
    :aws_secret_access_key  => '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'
  }
  config.fog_directory  = 'ksupport-development'
end