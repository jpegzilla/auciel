# frozen_string_literal: true

require_relative './api_errors'

# used to format responses from the black desert api
module ResponseFormatter
  include ApiErrors

  def self.try_error(json)
    return false if json['resultCode'].zero?

    {
      resultCode: json['resultCode'],
      resultMsg: json['resultMsg']
    }.to_json
  end

  def self.format_item_response(data)
    json = JSON.parse(data)

    return try_error json if try_error json

    {
      data: json['detailList'].map { |e| { **e, id: e['mainKey'] } }
    }.to_json
  rescue NoMethodError, JSON::ParserError
    ApiErrors::UNEXPECTED_BLACK_DESERT_RESPONSE
  end

  def self.format_cat_response(data)
    json = JSON.parse(data)

    return try_error json if try_error json

    {
      data: json['marketList'].map { |e| { **e, id: e['mainKey'] } }
    }.to_json
  rescue NoMethodError, JSON::ParserError
    ApiErrors::UNEXPECTED_BLACK_DESERT_RESPONSE
  end

  def self.format_search_response(data)
    json = JSON.parse(data)

    return try_error json if try_error json

    {
      data: json['list'].map { |e| { **e, id: e['mainKey'] } }
    }.to_json
  rescue NoMethodError, JSON::ParserError
    ApiErrors::UNEXPECTED_BLACK_DESERT_RESPONSE
  end

  # rubocop:disable Metrics/MethodLength
  def self.format_price_list_response(data)
    json = JSON.parse(data)

    return try_error json if try_error json

    json.delete 'resultCode'

    res = {
      data: {
        pricePoints: json['priceList'],
        buySellCounts: json['marketConditionList'],
        **json
      }
    }

    res[:data].delete 'marketConditionList'
    res[:data].delete 'priceList'
    res.to_json
  rescue NoMethodError, JSON::ParserError
    ApiErrors::UNEXPECTED_BLACK_DESERT_RESPONSE
  end
  # rubocop:enable Metrics/MethodLength
end
