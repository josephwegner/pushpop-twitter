# from this repository run with:
# $ foreman run bundle exec ruby examples/jobs.rb

require 'pushpop'
require 'pushpop-twitter'

job do

  twitter do
    follow 'dzello'
  end

end

job do

  twitter do
    favorites
  end

  step do |tweets|
    puts tweets
  end

end

job do

  twitter do
    favorite(Twitter::Tweet.new(:id => 484793990345023489))
  end

  twitter do
    unfavorite(Twitter::Tweet.new(:id => 484793990345023489))
  end

  step do
    puts "Favorited then unfavorited tweet"
  end

end

Pushpop.run
