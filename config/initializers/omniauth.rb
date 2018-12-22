Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.credentials.facebook[:key], Rails.application.credentials.facebook[:secret]
  provider :google_oauth2, Rails.application.credentials.google_oauth2[:key], Rails.application.credentials.google_oauth2[:secret]
end
