# frozen_string_literal: true

# Default CarrierWave setup.
#
CarrierWave.configure do |config|
  config.permissions = 0o666
  config.directory_permissions = 0o777
  config.storage = :file
  config.enable_processing = !Rails.env.test?
  config.asset_host = ENV.fetch("HOST", nil)
end

# Setup CarrierWave to use Amazon S3. Add `gem "fog-aws" to your Gemfile.
if Rails.application.secrets.dig(:storage, :s3, :access_key_id).present?
  require "carrierwave/storage/fog"

  region= Rails.application.secrets.dig(:storage, :s3, :region)
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_provider = "fog/aws" # required
    config.fog_credentials = {
      provider: "AWS", # required
      aws_access_key_id: Rails.application.secrets.dig(:storage, :s3, :access_key_id), # required
      aws_secret_access_key: Rails.application.secrets.dig(:storage, :s3, :secret_access_key), # required
      region: region, # optional, defaults to 'us-east-1'
      host: "s3.#{region}.amazonaws.com" # optional, defaults to nil
    }
    config.fog_directory = Rails.application.secrets.dig(:storage, :s3, :bucket) # required
    config.fog_public = true # (optional) public readability, defaults to true
    config.fog_attributes = { "Cache-Control" => "max-age=#{365.days.to_i}" } # optional, defaults to {}
  end
end
