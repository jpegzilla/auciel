# black desert market api

this is a wrapper for the black desert central market api. the goal is to enable developers to get data from the market more easily.

## usage

### installing from rubygems
_no gem yet_

### using source code

```ruby
require 'lib/bdomapi'

# default port is 8888
server = BDOMAPI.new 8888

# server ready for requests at localhost:8888
server.listen
```

## endpoints

### `/item/:id`

retrieves information about an item based on its id. equivalent to `GetWorldMarketSubList` in the raw api. example:

```
GET https://localhost:8888/item/702

{
	"detailList": [
		{
			"pricePerOne": 10700,
			"totalTradeCount": 14269193,
			"keyType": 0,
			"mainKey": 702,
			"subKey": 0,
			"count": 0,
			"name": "Elixir of Will",
			"grade": 1,
			"mainCategory": 35,
			"subCategory": 2,
			"chooseKey": 0,
			"isGodrAyed": false
		}
	],
	"resultCode": 0,
	"resultMsg": ""
}

```