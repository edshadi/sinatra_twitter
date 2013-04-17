get '/' do
  redirect request_token.authorize_url
end

get '/auth' do
  get_access_token
  redirect 'tweet'
end

get '/tweet' do
  @tweets = client.home_timeline
  erb :tweets
end

post '/tweet' do
  content_type :json
  begin
    client.update params[:tweet]
    {:response => params[:tweet] }.to_json
  rescue Twitter::Error => e
    status 500
    e.wrapped_exception
  end
end
