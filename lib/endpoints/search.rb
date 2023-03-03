# frozen_string_literal: true

require 'httparty'
require_relative './../constants/constants'
require_relative './../utils/response_formatter'

# form data for various requests
module FormData
  def self.search_item_by_text_data(search_text)
    "__requestVerificationToken=#{Constants::RVT}&searchText=#{search_text}"
  end
end

# search for item and other search-related methods
module SearchEndpoints
  include Constants
  include FormData
  include ResponseFormatter

  def self.send_post_request(uri, data)
    uri_params = data
    uri_params = URI.encode_www_form(data) if data.is_a? Hash

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

  def self.search_item_by_text
    lambda do |req|
      search_text = req[:params]['q']
      uri = URI "#{Constants::ROOT_URL}#{Constants::MARKET_SEARCH_LIST}"
      form = FormData.search_item_by_text_data search_text
      res = send_post_request uri, form

      ResponseFormatter.format_search_response(respond_if_available(res))
    end
  end

  SEARCH_ITEM_BY_TEXT = {
    method: 'get',
    path: '/search',
    responder: search_item_by_text,
    opts: { content_type: 'application/json' }
  }.values.freeze
end
