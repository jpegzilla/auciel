# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective, Metrics/MethodLength

require_relative './api_errors'

# used to format responses from the black desert api
module ResponseFormatter
  include ApiErrors

  # returns an error message if the black desert api returns an error
  def self.try_error(json)
    return false if json['resultCode'].zero?

    {
      resultCode: json['resultCode'],
      resultMsg: json['resultMsg']
    }.to_json
  end

  # for /item/:id endpoint
  def self.format_item_response(data)
    json = JSON.parse(data)

    return try_error json if try_error json

    {
      data: json['detailList'].map do |e|
        {
          **e,
          id: e['mainKey']
        }.except('mainKey')
      end
    }.to_json
  rescue NoMethodError, JSON::ParserError
    ApiErrors::UNEXPECTED_BLACK_DESERT_RESPONSE
  end

  # for /item/:cat/:sub endpoint
  def self.format_cat_response(data)
    json = JSON.parse(data)

    return try_error json if try_error json

    {
      data: json['marketList'].map { |e| { **e, id: e['mainKey'] } }
    }.to_json
  rescue NoMethodError, JSON::ParserError
    ApiErrors::UNEXPECTED_BLACK_DESERT_RESPONSE
  end

  # for /search endpoint
  def self.format_search_response(data)
    json = JSON.parse(data)

    return try_error json if try_error json

    {
      data: json['list'].map { |e| { **e, id: e['mainKey'] } }
    }.to_json
  rescue NoMethodError, JSON::ParserError
    ApiErrors::UNEXPECTED_BLACK_DESERT_RESPONSE
  end

  # for /prices endpoint
  def self.format_price_list_response(data)
    json = JSON.parse(data)

    return try_error json if try_error json

    {
      data: {
        pricePoints: json['priceList'],
        buySellCounts: json['marketConditionList'],
        **json
      }.except('marketConditionList', 'priceList', 'resultCode')
    }.to_json
  rescue NoMethodError, JSON::ParserError
    ApiErrors::UNEXPECTED_BLACK_DESERT_RESPONSE
  end

  # for /hot endpoint
  def self.format_hot_response(data)
    json = JSON.parse(data)

    return try_error json if try_error json

    {
      data: json['hotList'].map { |e| { **e, id: e['mainKey'] } }
    }.to_json
  rescue NoMethodError, JSON::ParserError
    ApiErrors::UNEXPECTED_BLACK_DESERT_RESPONSE
  end

  # for /waitlist endpoint
  def self.format_waitlist_response(data)
    json = JSON.parse(data)

    return try_error json if try_error json

    {
      data: json['_waitList'].map do |e|
        {
          **e,
          id: e['mainKey'],
          waitEndTime: e['_waitEndTime'],
          pricePerOne: e['_pricePerOne']
        }.except('_pricePerOne', '_waitEndTime')
      end
    }.to_json
  rescue NoMethodError, JSON::ParserError
    ApiErrors::UNEXPECTED_BLACK_DESERT_RESPONSE
  end
end
