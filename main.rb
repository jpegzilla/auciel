# frozen_string_literal: true

require 'tsurezure'
require_relative './endpoints/item'

# main class for bdomapi
module BDOMAPI
  include ItemEndpoints

  @server = Tsurezure.new 8888

  # /item/:id
  @server.register(*ItemEndpoints::GET_ITEM_BY_ID)

  def self.listen
    @server.listen lambda { |opts|
      puts "listening on port #{opts[:port]}!"
    }
  end
end

BDOMAPI.listen
