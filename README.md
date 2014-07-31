## pushpop-twitter

Pushpop plugin for the [Twitter API](https://dev.twitter.com).

### Installation

Add the `pushpop-twitter` gem to your Gemfile:

``` ruby
gem 'pushpop-twitter'
```

or install it directly:

``` shell
$ gem install pushpop-twitter
```

### Usage

Create a new Twitter [developer app](https://dev.twitter.com) and generate OAuth credentials for the Twitter account that you want to make API calls under. Add the app's API keys and OAuth credentials to the process environment. A sample .env file would look like this:

```
TWITTER_CONSUMER_KEY=XXXXXXXXXXXXXXXXX
TWITTER_CONSUMER_SECRET=XXXXXXXXXXX
TWITTER_OAUTH_TOKEN=XXXXXXXXXXXXXXXXXXXXXXXX
TWITTER_OAUTH_SECRET=XXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

Substitute your values for the X's.

### Examples

Here's a few examples of what you can do:

``` ruby
require 'pushpop'
require 'pushpop-twitter'

job do

  twitter do
    follow 'dzello'
  end

end

job do

  twitter do
    user 'dzello'
  end

end

job do

  twitter do
    favorites
  end

end

job do

  twitter do
    favorite(Twitter::Tweet.new(:id => 484793990345023489))
  end

  twitter do
    unfavorite(Twitter::Tweet.new(:id => 484793990345023489))
  end

end
```

### Contributing

Code and documentation issues and pull requests are welcome. Help us make this template as
useful as possible!
