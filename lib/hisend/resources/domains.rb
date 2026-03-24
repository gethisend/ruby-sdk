module Hisend
  module Resources
    class Domains
      def initialize(client)
        @client = client
      end

      def list
        @client.request(:get, 'domains')
      end

      def get(id)
        @client.request(:get, "domains/#{id}")
      end

      def verify(id)
        @client.request(:get, "domains/#{id}/verify")
      end

      def add(data)
        @client.request(:post, 'domains', data)
      end

      def delete(id)
        @client.request(:delete, "domains/#{id}")
      end
    end
  end
end
