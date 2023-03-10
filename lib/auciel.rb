# frozen_string_literal: true

require 'tsurezure'
require_relative './endpoints/item'
require_relative './endpoints/search'
require_relative './endpoints/prices'
require_relative './endpoints/hot'
require_relative './endpoints/waitlist'

# main class for auciel
class Auciel
  include ItemEndpoints
  include SearchEndpoints
  include PriceEndpoints
  include HotEndpoints
  include WaitlistEndpoints

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
    @server.register(*PriceEndpoints::GET_PRICE_LIST_BY_ID)

    # /hot
    @server.register(*HotEndpoints::GET_HOT_ITEMS_LIST)

    # /waitlist
    @server.register(*WaitlistEndpoints::GET_WAITLIST_ITEMS)
  end

  def listen
    @server.listen lambda { |opts|
      puts "listening on port #{opts[:port]}!"
    }
  rescue Interrupt
    puts '[auciel] shutting down.'
  end

  def all_endpoints
    {
      get_item_by_id: ItemEndpoints::GET_ITEM_BY_ID,
      get_item_by_category: ItemEndpoints::GET_ITEM_BY_CATEGORY,
      search_item_by_text: SearchEndpoints::SEARCH_ITEM_BY_TEXT,
      get_price_list_by_id: PriceEndpoints::GET_PRICE_LIST_BY_ID,
      get_hot_items_list: HotEndpoints::GET_HOT_ITEMS_LIST,
      get_waitlist_items: WaitlistEndpoints::GET_WAITLIST_ITEMS
    }
  end
end
