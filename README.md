# docker-smashing

This sample project contains the minimal structure for a Ruby Smashing application
deployment.

## How to use

Clone the repository:
```
git clone git@github.com:atilleh/docker-smashing.git docker-smashing
```
Move into the cloned repository:
```
cd docker-smashing
```

Update environment variables to match with your information:
```
(nano, vim) .env
```

Create the basic Smashing directories structure:
```
docker-compose run smashing smashing new .
```

Launch Smashing to check if everything is fine:
```
docker-compose up
```

## Make Twitter module work

Update the newly created `smashing/jobs/twitter.rb` file to match Twitter parameters with :
```ruby
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_TOKEN_SECRET']
end
```

## Set the Smashing API key

Update `smashing/config.ru` file and set `:auth_token` :

```ruby
set :auth_token, ENV['SMASHING_KEY']
```
