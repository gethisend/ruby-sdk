require 'minitest/autorun'
require_relative '../lib/hisend'
require 'ostruct'

class TestHisendClient < Minitest::Test
  def setup
    @client = Hisend::Client.new(api_key: 'test_api_key_123')
  end

  def test_get_domains_has_correct_headers_and_decodes_json
    # Create a mock response object
    mock_response = Net::HTTPSuccess.new('1.1', '200', 'OK')
    def mock_response.body
      '[{"id": 1, "name": "example.com"}]'
    end

    # Mock the HTTP instance
    mock_http = Minitest::Mock.new
    
    # We expect `use_ssl=` to be called with true
    mock_http.expect(:use_ssl=, nil, [true])
    
    # We expect `request` to be called with a Net::HTTP::Get request object
    mock_http.expect(:request, mock_response) do |req|
      req.is_a?(Net::HTTP::Get) &&
      req['Authorization'] == 'Bearer test_api_key_123' &&
      req['Content-Type'] == 'application/json'
    end

    # Stub Net::HTTP.new to return our mock
    Net::HTTP.stub(:new, mock_http) do
      domains = @client.domains.list

      assert_instance_of Array, domains
      assert_equal 1, domains.length
      assert_equal 1, domains.first[:id]
      assert_equal 'example.com', domains.first[:name]
    end

    # Verify everything was called as expected
    mock_http.verify
  end
end
