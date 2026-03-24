module Hisend
  module Resources
    class Emails
      def initialize(client)
        @client = client
      end

      def list
        @client.request(:get, 'emails')
      end

      def get(id)
        @client.request(:get, "emails/#{id}")
      end

      def send(data)
        @client.request(:post, 'emails', data)
      end

      def send_batch(data)
        @client.request(:post, 'emails/batch', data)
      end
    end
  end
end
