require 'openssl'

module Hisend
  # Hisend Webhook signature verification helper.
  #
  # Example (Rails):
  #
  #   class WebhooksController < ApplicationController
  #     skip_before_action :verify_authenticity_token
  #
  #     def hisend
  #       payload   = request.raw_post
  #       signature = request.headers['X-Hisend-Signature']
  #       secret    = ENV['HISEND_WEBHOOK_SECRET']
  #
  #       unless Hisend::Webhook.verify(payload, signature, secret)
  #         render json: { error: 'Invalid signature' }, status: :unauthorized
  #         return
  #       end
  #
  #       event = JSON.parse(payload)
  #       head :ok
  #     end
  #   end
  module Webhook
    # Verify the HMAC-SHA256 signature of an incoming Hisend webhook.
    #
    # @param payload   [String] Raw request body exactly as received.
    # @param signature [String] Value of the X-Hisend-Signature header.
    # @param secret    [String] Your Webhook Signing Secret (starts with whsec_).
    #
    # @return [Boolean] true if the signature is valid, false otherwise.
    def self.verify(payload, signature, secret)
      return false if [payload, signature, secret].any?(&:nil?)
      return false if payload.empty? || signature.empty? || secret.empty?

      expected = OpenSSL::HMAC.hexdigest('SHA256', secret, payload)

      # Rack / ActiveSupport provides secure_compare – fall back to plain == if unavailable.
      if defined?(ActiveSupport::SecurityUtils)
        ActiveSupport::SecurityUtils.secure_compare(expected, signature)
      else
        OpenSSL.fixed_length_secure_compare(expected, signature)
      end
    end
  end
end
