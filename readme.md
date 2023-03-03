# auciel

auciel is a wrapper for the black desert central market api. its purpose is to enable developers to get data from the market more easily, without having to figure out the strict (and odd) request structures required for the raw central market api.

## usage

### installing from rubygems

_no gem yet_

### executable

_coming soon_

### using source code

download this repo. then, in your ruby script:

```ruby
require_relative 'path/to/lib/auciel'

# default port is 8888
server = Auciel.new 8888

# server will be ready for requests at localhost:8888
server.listen
```

you can also just run `ruby main.rb` in the root directory and a server will start at `localhost:8888`.

## endpoints

### `/item/:id`

retrieves information about an item based on its id. equivalent to `GetWorldMarketSubList` in the raw api. example:

`GET https://localhost:8888/item/702`

```js
{
  "data": [
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
  ]
}

```

### `/item/:cat/:sub`

retrieves a list of items in a category and subcategory. equivalent to `GetWorldMarketList` in the raw api. example:

`GET https://localhost:8888/item/35/1`
```js
{
  "data": [
    {
      "mainKey": 504,
      "sumCount": 0,
      "name": "Melee AP Enhancer",
      "grade": 0,
      "isGodrAyed": false,
      "minPrice": 93500,
      "id": 504
    },
    {
      "mainKey": 505,
      "sumCount": 0,
      "name": "Ranged AP Enhancer",
      "grade": 0,
      "isGodrAyed": false,
      "minPrice": 93500,
      "id": 505
    },

    ...

```

### `/search?q=<search text>`

retrieves a list of items whose names match the provided **url encoded** search string. equivalent to `GetWorldMarketSearchList` in the raw api. example:

`GET http://localhost:8888/search?q=blood`
```js
{
  "data": [
    {
      "mainKey": 3040,
      "sumCount": 1,
      "totalSumCount": 77500000,
      "name": "Muskan's Bloody Steel Helmet",
      "grade": 2,
      "isGodrAyed": false,
      "id": 3040
    },
    {
      "mainKey": 4453,
      "sumCount": 2674,
      "totalSumCount": 236000,
      "name": "Blood Ruby",
      "grade": 0,
      "isGodrAyed": false,
      "id": 4453
    },
    {
      "mainKey": 5005,
      "sumCount": 30309,
      "totalSumCount": 19000,
      "name": "Bloody Tree Knot",
      "grade": 0,
      "isGodrAyed": false,
      "id": 5005
    },

    ...

```

### `/prices/:id`

retrieves a detailed price list for a specified item id. equivalent to `GetItemSellBuyInfo` in the raw api. example:

`GET http://localhost:8888/search?q=blood`
```js
{
  "data": {
    "pricePoints": [
      11800,
      11900,
      12000,
      12100,
      12200,
      12300,
      12400,
      12500,
      12600,
      12700
    ],
    "buySellCounts": [
      {
        "sellCount": 0,
        "buyCount": 500,
        "pricePerOne": 11000
      },
      {
        "sellCount": 0,
        "buyCount": 500,
        "pricePerOne": 11100
      },
      {
        "sellCount": 0,
        "buyCount": 0,
        "pricePerOne": 11200
      },

    ...

```

## other info

auciel is the name of the central market director at old wisdom tree.