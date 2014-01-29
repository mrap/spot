Paperclip::Attachment.default_options.update({
  :hash_secret => ENV['PAPERCLIP_HASH_SECRET']
})

# Environment Configurations

unless Rails.env.production? || Rails.env.development?
  Paperclip::Attachment.default_options.merge!({
    :url => "/system/:rails_env/:class/:attachment/:hash/:style/:filename",
    :path => ":rails_root/public:url"
  })
end

if Rails.env.production? || Rails.env.development?
  Paperclip::Attachment.default_options.merge!({
    storage: :s3,
    s3_credentials: {
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      bucket: ENV['AWS_BUCKET'],
      s3_host_name: ENV['AWS_HOST_NAME']
    },
    path: ":class/:attachment/:hash/:style.:extension"
  })

end

