get '/' do
  erb :index
end

# STEP 1 (sign-in was clicked)
get '/oauth' do
  consumer = OAuth::Consumer.new(
    ENV["TWITTER_KEY"],
    ENV["TWITTER_SECRET"],
    :site => "https://api.twitter.com")
  session[:request_token] = consumer.get_request_token(:oauth_callback => "http://localhost:9292/auth")

  redirect session[:request_token].authorize_url
end

# STEP 2 (twitter redirects here after authorized)
get '/auth' do
  # get the access token
  access_token = session[:request_token].get_access_token(:oauth_verifier => params[:oauth_verifier])

  session.delete(:request_token)

  client = Twitter::Client.new(
    :consumer_key => ENV["TWITTER_KEY"],
    :consumer_secret => ENV["TWITTER_SECRET"],
    :oauth_token => access_token.token,
    :oauth_token_secret => access_token.secret
  )

  erb :tweet
end
