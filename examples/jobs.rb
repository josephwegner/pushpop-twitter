# from this repository run with:
# $ foreman run bundle exec ruby examples/jobs.rb

require 'pushpop'
require_relative '../lib/pushpop-twitter'

job do
  twitter do
    follow 'dzello'
  end
end

job do
  twitter do
    favorite({ :id_str => '484793990345023489' })
  end
end

Pushpop.run
