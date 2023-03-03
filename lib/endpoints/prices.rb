# frozen_string_literal: true

require 'httparty'
require_relative './../constants/constants'
require_relative './../utils/response_formatter'

# form data for various requests
module FormData
  def self.price_list_data(id)
    {
      __requestVerificationToken: Constants::RVT,
      mainKey: id,
      subKey: 0,
      keyType: 0,
      isUp: true
    }
  end
end

# get price list by id and name, and other price-related endpoints
module PriceEndpoints
  include Constants
  include FormData
  include ResponseFormatter

  def self.send_post_request(uri, data)
    uri_params = URI.encode_www_form data

    HTTParty.post(
      uri,
      body: uri_params,
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

  def self.price_list_by_id_and_name
    lambda do |req|
      item_id = req[:vars]['id']
      uri = URI "#{Constants::ROOT_URL}#{Constants::MARKET_SELL_BUY_INFO}"
      form = FormData.price_list_data item_id
      res = send_post_request uri, form

      ResponseFormatter.format_price_list_response(respond_if_available(res))
    end
  end

  GET_PRICE_LIST_BY_ID_AND_NAME = {
    method: 'get',
    path: '/prices/:id',
    responder: price_list_by_id_and_name,
    opts: { content_type: 'application/json' }
  }.values.freeze
end
