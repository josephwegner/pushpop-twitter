require 'pushpop'
require 'twitter'

module Pushpop

  class Twitter < Step

    PLUGIN_NAME = 'twitter'

    Pushpop::Job.register_plugin(PLUGIN_NAME, self)

    def initialize(*args)
      super
      @twitter = ::Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = ENV['TWITTER_OAUTH_TOKEN']
        config.access_token_secret = ENV['TWITTER_OAUTH_SECRET']
      end
    end

    def run(last_response=nil, step_responses=nil)

      self.configure(last_response, step_responses)

      case @command
      when 'follow'
        @twitter.follow @username
      when 'favorite'
        @twitter.favorite @tweet_id
      else
        raise 'No command specified!'
      end

    end

    def follow(username, options={})
      @command = 'follow'
      @username = username
      @options = options
    end

    # param tweet, tweet-sized JSON
    def favorite(tweet, options={})
      @command = 'favorite'
      @tweet_id = tweet[:id_str]
      @options = options
    end

    def configure(last_response=nil, step_responses=nil)
      self.instance_exec(last_response, step_responses, &block)
    end

  end

end
