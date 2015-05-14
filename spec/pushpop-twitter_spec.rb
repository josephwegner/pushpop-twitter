require 'spec_helper'

describe Pushpop::Twitter do

  let(:example_tweet) { Twitter::Tweet.new({
    id: 449660889793581056,
    id_str: '449660889793581056',
    user: {
      screen_name: 'dzello'
    }
  }) }

  describe 'follow' do
    step = nil

    before(:each) do
      stub_request(:post, "https://api.twitter.com/oauth2/token").
        with(:body => "grant_type=client_credentials")

      stub_request(:get, "https://api.twitter.com/1.1/account/verify_credentials.json?skip_status=true").
        to_return(body: File.read("spec/fixtures/dzello.json"))

      stub_request(:post, "https://api.twitter.com/1.1/users/lookup.json").
        with(:body => {:screen_name => 'dzello'}).
        to_return(body: File.read("spec/fixtures/users.json"))

      stub_request(:get, "https://api.twitter.com/1.1/friends/ids.json?cursor=-1&user_id=45297280").
        to_return(body: File.read("spec/fixtures/ids.json"))

      stub_request(:post, "https://api.twitter.com/1.1/friendships/create.json").
        with(:body => {:user_id => '45297280'}).
        to_return(body: File.read("spec/fixtures/dzello.json"))
    end

    it 'follows a user' do
      step = Pushpop::Twitter.new do |last_response|
        follow last_response
      end

      result = step.run('dzello')
      expect(result.first.screen_name).to eq('dzello')
    end

    it 'returns the value of the block, if there is one' do
      step = Pushpop::Twitter.new do |last_response|
        follow last_response

        'test'
      end

      result = step.run('dzello')
      expect(result).to eq('test')
    end
  end

  describe 'favorite' do
    before(:each) do
      stub_request(:post, "https://api.twitter.com/1.1/favorites/create.json").
        with(:body => {:id => '449660889793581056'}).
        to_return(body: File.read("spec/fixtures/status.json"))

      stub_request(:post, "https://api.twitter.com/oauth2/token").
        with(:body => "grant_type=client_credentials")
    end

    it 'favorites a tweet' do
      step = Pushpop::Twitter.new do |last_response|
        favorite last_response
      end

      result = step.run(example_tweet)
      expect(result.first.id).to eq(449660889793581056)
    end

    it 'returns teh value of the block, if there is one' do
      step = Pushpop::Twitter.new do |last_response|
        favorite last_response

        'test'
      end

      result = step.run(example_tweet)
      expect(result).to eq('test')
    end
  end

  describe 'unfavorite' do
    it 'unfavorites a tweet' do
      step = Pushpop::Twitter.new do |last_response|
        unfavorite last_response
      end

      stub_request(:post, "https://api.twitter.com/1.1/favorites/destroy.json").
        with(:body => {:id => '449660889793581056'}).
        to_return(body: File.read("spec/fixtures/status.json"))

      stub_request(:post, "https://api.twitter.com/oauth2/token").
        with(:body => "grant_type=client_credentials")

      result = step.run(example_tweet)
      expect(result.first.id).to eq(449660889793581056)
    end
  end

  describe 'favorites' do
    it 'gets a list of favorites' do
      step = Pushpop::Twitter.new do |last_response|
        favorites
      end

      stub_request(:post, "https://api.twitter.com/oauth2/token").
        with(:body => "grant_type=client_credentials")

      stub_request(:get, "https://api.twitter.com/1.1/favorites/list.json").
        to_return(body: File.read("spec/fixtures/statuses.json"))

      result = step.run
      expect(result.first.id).to eq(449660889793581056)
    end
  end

  describe 'user' do
    it 'gets a user' do
      step = Pushpop::Twitter.new do |last_response|
        user "dzello"
      end

      stub_request(:post, "https://api.twitter.com/oauth2/token").
        with(:body => "grant_type=client_credentials")

      stub_request(:get, "https://api.twitter.com/1.1/users/show.json?screen_name=dzello").
        to_return(body: File.read("spec/fixtures/user.json"))

      result = step.run
      expect(result.id).to eq(45297280)
    end
  end
end
