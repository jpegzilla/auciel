# frozen_string_literal: true

require 'httparty'
require_relative './../constants/constants'
require_relative './../utils/response_formatter'

# form data for various requests
module FormData
  def self.item_by_id_data(id)
    {
      __requestVerificationToken: Constants::RVT,
      mainKey: id,
      usingCleint: 0
    }
  end

  def self.item_by_cat_data(cat, sub)
    {
      __requestVerificationToken: Constants::RVT,
      mainCategory: cat,
      subCategory: sub
    }
  end
end

# get item by id and other item-related methods
module ItemEndpoints
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

  def self.item_by_id
    lambda do |req|
      item_id = req[:vars]['id']
      uri = URI "#{Constants::ROOT_URL}#{Constants::MARKET_SUB_LIST}"
      form = FormData.item_by_id_data item_id
      res = send_post_request uri, form

      ResponseFormatter.format_item_response(respond_if_available(res))
    end
  end

  def self.items_by_category
    lambda do |req|
      item_cat = req[:vars]['cat']
      item_sub = req[:vars]['sub']
      uri = URI "#{Constants::ROOT_URL}#{Constants::WORLD_MARKET_LIST}"
      form = FormData.item_by_cat_data item_cat, item_sub
      res = send_post_request uri, form

      ResponseFormatter.format_cat_response(respond_if_available(res))
    end
  end

  GET_ITEM_BY_ID = {
    method: 'get',
    path: '/item/:id',
    responder: item_by_id,
    opts: { content_type: 'application/json' }
  }.values.freeze

  GET_ITEM_BY_CATEGORY = {
    method: 'get',
    path: '/item/:cat/:sub',
    responder: items_by_category,
    opts: { content_type: 'application/json' }
  }.values.freeze
end
