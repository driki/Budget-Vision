Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.full_host = ENV['OMNI_AUTH_FULL_HOST']
  provider :developer unless Rails.env.production?
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'], {:client_options => {:ssl => {:ca_file => "/usr/lib/ssl/certs/ca-certificates.crt"}}}
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], {
	  :client_options => {
		  :ssl => {:ca_file => "/usr/lib/ssl/certs/ca-certificates.crt"}},
  		:authorize_params => { :display => 'popup' }
  	}
end