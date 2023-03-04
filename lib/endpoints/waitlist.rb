# frozen_string_literal: true

require 'httparty'
require_relative './../constants/constants'
require_relative './../utils/response_formatter'

# get a list of items in the registration queue
module WaitlistEndpoints
  include Constants
  include FormData
  include ResponseFormatter

  def self.send_post_request(uri)
    HTTParty.post(
      uri,
      headers: Constants::REQUEST_OPTS[:headers]
    )
  end

  def self.respond_if_available(res)
    return res.body if res.body

    {
      error: 'invalid response from the black desert api.',
      response: res
    }.to_json
  end

  def self.waitlist_items
    lambda do |_req|
      uri = URI "#{Constants::ROOT_URL}#{Constants::MARKET_WAIT_LIST}"
      res = send_post_request uri

      ResponseFormatter.format_waitlist_response(respond_if_available(res))
    end
  end

  GET_WAITLIST_ITEMS = {
    method: 'get',
    path: '/waitlist',
    responder: waitlist_items,
    opts: { content_type: 'application/json' }
  }.values.freeze
end
