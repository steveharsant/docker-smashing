#!/bin/sh
set -u

declare () {
  echo "Will use .env to update Smashing files: "
  echo "Continue ?"
}

update_config () {
  auth_token=$(cat .env | grep SMASHING_KEY | cut -d'=' -f2 | tr -d "\n")
  sed -i "s/YOUR_AUTH_TOKEN/$auth_token/" ./smashing/config.ru
}

update_twitter () {
  twitter_consumer_key=$(cat .env | grep TWITTER_CONSUMER_KEY | cut -d'=' -f2 | tr -d "\n")
  twitter_consumer_secret=$(cat .env | grep TWITTER_CONSUMER_SECRET | cut -d'=' -f2 | tr -d "\n")
  twitter_access_token=$(cat .env | grep TWITTER_ACCESS_TOKEN | cut -d'=' -f2 | tr -d "\n")
  twitter_token_secret=$(cat .env | grep TWITTER_TOKEN_SECRET | cut -d'=' -f2 | tr -d "\n")

  sed -i "s/YOUR_CONSUMER_KEY/$twitter_consumer_key/" ./smashing/jobs/twitter.rb
  sed -i "s/YOUR_CONSUMER_SECRET/$twitter_consumer_secret/" ./smashing/jobs/twitter.rb
  sed -i "s/YOUR_OAUTH_TOKEN/$twitter_access_token/" ./smashing/jobs/twitter.rb
  sed -i "s/YOUR_OAUTH_SECRET/$twitter_token_secret/" ./smashing/jobs/twitter.rb
}
update () {
  for file in \
    ./smashing/config.ru \
    ./smashing/jobs/twitter.rb ; do

    if [[ ! -f "$file" ]] ;
    then
      echo "$file not found. Exiting."
      exit 1
    fi
  done

  update_config
  update_twitter

  if [[ "$?" == 0 ]] ;
  then
    echo "Files updated."
  fi
}

wont_update () {
  exit 1
}

declare

read continue_update
case $continue_update in
  [yYoO]*) update;;
  [nN]*) wont_update;;
  *) echo "Undefined option. (y/n)." && exit 1;;
esac
