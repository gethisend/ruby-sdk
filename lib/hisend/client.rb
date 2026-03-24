module Hisend
  class Client
    attr_reader :emails, :domains, :routing, :threads

    def initialize(api_key:, base_url: 'https://api.hisend.app/v1')
      @api_key = api_key
      @base_url = base_url.chomp('/')

      @emails = Hisend::Resources::Emails.new(self)
      @domains = Hisend::Resources::Domains.new(self)
      @routing = Hisend::Resources::Routing.new(self)
      @threads = Hisend::Resources::Threads.new(self)
    end

    def request(method, endpoint, payload = nil)
      uri = URI("#{@base_url}/#{endpoint.sub(/^\//, '')}")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'

      req_class = case method.to_s.upcase
                  when 'GET' then Net::HTTP::Get
                  when 'POST' then Net::HTTP::Post
                  when 'PUT' then Net::HTTP::Put
                  when 'DELETE' then Net::HTTP::Delete
                  else raise ArgumentError, "Unsupported method: #{method}"
                  end

      req = req_class.new(uri)
      req['Authorization'] = "Bearer #{@api_key}"
      req['Content-Type'] = 'application/json'
      req['Accept'] = 'application/json'

      if payload
        # Map :from_ to :from internally for ruby aesthetics if passed as a symbol
        if payload.key?(:from_)
          payload[:from] = payload.delete(:from_)
        end
        req.body = JSON.generate(payload)
      end

      response = http.request(req)
      body = response.body.to_s.empty? ? nil : JSON.parse(response.body, symbolize_names: true)

      unless response.is_a?(Net::HTTPSuccess)
        error_msg = body.is_a?(Hash) && (body[:message] || body[:error]) ? (body[:message] || body[:error]) : response.body
        raise Hisend::Error.new("API request failed: #{error_msg}", response.code.to_i)
      end

      body
    rescue JSON::ParserError
      raise Hisend::Error.new("Invalid JSON response from server: #{response.body}", response&.code&.to_i)
    end
  end
end
