# frozen_string_literal: true

module Constants
  COOKIE =
    '__RequestVerificationToken=0q_pyZ8OMkALLxxv_pj6ty10hXKTDq3Sl_1NAbV5WYhUAbNvcurT6GwSUDmBRnaZVyEmd0lcTlR3I6X7_cXkAwH-nGQG_G2E6MQZPNcfNd41'
  RVT = 'MGf54RSTVQkYrPo4Dvaf9IOuSilYwQIzWfdBI4PhFrV1l1o_e0BRmf78J6I7pVn_gcqj5DAv-G3MfFiWoUqFE3R62-Kxdcm4CgkRGd7oq7Y1'
  ROOT_URL = 'https://na-trade.naeu.playblackdesert.com/Home'
  WORLD_MARKET_LIST = '/GetWorldMarketList'
  MARKET_SUB_LIST = '/GetWorldMarketSubList'
  MARKET_SEARCH_LIST = '/GetWorldMarketSearchList'
  MARKET_SELL_BUY_INFO = '/GetItemSellBuyInfo'
  MARKET_HOT_LIST = '/GetWorldMarketHotList'
  MARKET_WAIT_LIST = '/GetWorldMarketWaitList'
  REQUEST_OPTS = {
    method: 'post',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'User-Agent':
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
      Cookie: COOKIE
    }
  }.freeze
end
