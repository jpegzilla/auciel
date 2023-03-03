# frozen_string_literal: true

require 'tsurezure'
require_relative './endpoints/item'
require_relative './endpoints/search'
require_relative './endpoints/prices'

# main class for bdomapi
class Auciel
  include ItemEndpoints
  include SearchEndpoints
  include PriceEndpoints

  def initialize(port = 8888)
    @server = Tsurezure.new port
    register_endpoints
  end

  def register_endpoints
    # /item/:id
    @server.register(*ItemEndpoints::GET_ITEM_BY_ID)

    # /item/:cat/:sub
    @server.register(*ItemEndpoints::GET_ITEM_BY_CATEGORY)

    # /search
    # requires a urlencoded string
    @server.register(*SearchEndpoints::SEARCH_ITEM_BY_TEXT)

    # /prices/:id
    @server.register(*PriceEndpoints::GET_PRICE_LIST_BY_ID_AND_NAME)
  end

  def listen
    @server.listen lambda { |opts|
      puts "listening on port #{opts[:port]}!"
    }
  end
end
