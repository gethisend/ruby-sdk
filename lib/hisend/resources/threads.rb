module Hisend
  module Resources
    class Threads
      def initialize(client)
        @client = client
      end

      def list
        @client.request(:get, 'threads')
      end

      def get_emails(id)
        @client.request(:get, "threads/#{id}/emails")
      end
    end
  end
end
