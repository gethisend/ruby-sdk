module Hisend
  module Resources
    class Routing
      def initialize(client)
        @client = client
      end

      def list(domain_id)
        @client.request(:get, "domains/#{domain_id}/routing")
      end

      def create(domain_id, data)
        @client.request(:post, "domains/#{domain_id}/routing", data)
      end

      def update(domain_id, id, data)
        @client.request(:put, "domains/#{domain_id}/routing/#{id}", data)
      end

      def get(domain_id, id)
        @client.request(:get, "domains/#{domain_id}/routing/#{id}")
      end

      def delete(domain_id, id)
        @client.request(:delete, "domains/#{domain_id}/routing/#{id}")
      end
    end
  end
end
