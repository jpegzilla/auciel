# frozen_string_literal: true

require 'tsurezure'
require_relative './endpoints/item'

# main class for bdomapi
class Auciel
  include ItemEndpoints

  def initialize(port = 8888)
    @server = Tsurezure.new port
    register_endpoints
  end

  def register_endpoints
    # /item/:id
    @server.register(*ItemEndpoints::GET_ITEM_BY_ID)
  end

  def listen
    @server.listen lambda { |opts|
      puts "listening on port #{opts[:port]}!"
    }
  end
end
