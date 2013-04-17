helpers do
  def consumer
    session[:consumer] ||= OAuth::Consumer.new ENV["TWITTER_KEY"], ENV["TWITTER_SECRET"], :site => "https://api.twitter.com"
  end

  def request_token
    session[:request_token] ||= consumer.get_request_token(:oauth_callback => "http://localhost:9292/auth")
  end

  def get_access_token
    access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    session[:token], session[:secret] = access_token.token, access_token.secret
    session.delete(:request_token)
  end

  def token
    session[:token]
  end

  def secret
    session[:secret]
  end

  def client
    puts "im here" if @client
    @client ||= Twitter::Client.new(
      :consumer_key => ENV["TWITTER_KEY"],
      :consumer_secret => ENV["TWITTER_SECRET"],
      :oauth_token => token,
      :oauth_token_secret => secret
    )
  end
end
