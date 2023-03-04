# frozen_string_literal: true

require 'httparty'
require_relative './../constants/constants'
require_relative './../utils/response_formatter'

# get a list of currently popular items
module HotEndpoints
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

  def self.hot_items
    lambda do |_req|
      uri = URI "#{Constants::ROOT_URL}#{Constants::MARKET_HOT_LIST}"
      res = send_post_request uri

      ResponseFormatter.format_hot_response(respond_if_available(res))
    end
  end

  GET_HOT_ITEMS_LIST = {
    method: 'get',
    path: '/hot',
    responder: hot_items,
    opts: { content_type: 'application/json' }
  }.values.freeze
end
