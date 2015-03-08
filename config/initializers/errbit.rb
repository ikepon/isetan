Airbrake.configure do |config|
  config.api_key = '65eace1205ffe28a5de4046919367eed'
  config.host    = 'ikepon-errbit.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
end
