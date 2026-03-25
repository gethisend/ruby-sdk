require 'json'
require 'net/http'
require 'uri'

require_relative 'hisend/errors'
require_relative 'hisend/client'
require_relative 'hisend/resources/domains'
require_relative 'hisend/resources/emails'
require_relative 'hisend/resources/routing'
require_relative 'hisend/resources/threads'
require_relative 'hisend/webhook'

module Hisend
  # Entry point is Hisend::Client
end
