# auciel

auciel is a wrapper for the black desert central market api. its purpose is to enable developers to get data from the market more easily, without having to figure out the strict (and odd) request structures required for the raw central market api.

built with the [tsurezure](https://github.com/jpegzilla/tsurezure) [![gem version](https://badge.fury.io/rb/tsurezure.svg)](https://badge.fury.io/rb/tsurezure) framework.

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

retrieves a list of items in a [category and subcategory](#item-categories). equivalent to `GetWorldMarketList` in the raw api. example:

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

retrieves a detailed price list for a specified item id. equivalent to `GetItemSellBuyInfo` in the raw api, and similar to `GetBiddingInfoList`. example:

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

### `/hot`

retrieves a list of currently popular items. equivalent to `GetWorldMarketHotList` in the raw api. example:

`GET http://localhost:8888/hot`
```js
{
  "data": [
    {
      "subtype": 0,
      "pricePerOne": 66000,
      "totalTradeCount": 340891,
      "fluctuationType": 2,
      "fluctuationPrice": 12500,
      "keyType": 0,
      "mainKey": 641,
      "subKey": 0,
      "count": 0,
      "name": "[Party] Elixir of Fury",
      "grade": 1,
      "mainCategory": 35,
      "subCategory": 0,
      "chooseKey": 0,
      "isGodrAyed": false,
      "id": 641,
      "fluctuationDirection": "up"
    },
    {
      "subtype": 0,
      "pricePerOne": 47800,
      "totalTradeCount": 1780501,
      "fluctuationType": 1,
      "fluctuationPrice": 12200,
      "keyType": 0,
      "mainKey": 683,
      "subKey": 0,
      "count": 8446,
      "name": "Surging Energy Elixir",
      "grade": 2,
      "mainCategory": 35,
      "subCategory": 0,
      "chooseKey": 0,
      "isGodrAyed": false,
      "id": 683,
      "fluctuationDirection": "down"
    },

    ...

```

### `/waitlist`

retrieves a list of currently waitlisted items. equivalent to `GetWorldMarketWaitList` in the raw api. example:

`GET http://localhost:8888/waitlist`
```js
{
  "data": [
    {
      "keyType": 0,
      "mainKey": 11103,
      "subKey": 0,
      "count": 0,
      "name": "Urugon's Shoes",
      "grade": 3,
      "mainCategory": 15,
      "subCategory": 0,
      "chooseKey": 20,
      "isGodrAyed": false,
      "id": 11103,
      "waitEndTime": "2023-03-04T20:03:55+00:00",
      "waitEndTimestampMs": 1677960235417,
      "pricePerOne": 12400000000
    },
    {
      "keyType": 0,
      "mainKey": 12230,
      "subKey": 0,
      "count": 0,
      "name": "Basilisk's Belt",
      "grade": 3,
      "mainCategory": 20,
      "subCategory": 0,
      "chooseKey": 5,
      "isGodrAyed": false,
      "id": 12230,
      "waitEndTime": "2023-03-04T20:11:04+00:00",
      "waitEndTimestampMs": 1677960664373,
      "pricePerOne": 53000000000
    },

    ...

```

## item categories

here's a list of item types with their categories / subcategories for the `item/:cat/:sub` endpoint. for example, you could retrieve a list of foods at `item/35/4`.

item type             | category | subcategories
----------------------|----------|--------------
main weapon           | 1        | 1-20
sub-weapon            | 5        | 1-18
awakening             | 10       | 1-24
armor                 | 15       | 1-6
accessories           | 20       | 1-4
lightstone            | 85       | 1-5
material              | 25       | 1-8
enhancement / upgrade | 30       | 1-2
consumables           | 35       | 1-8
life tools            | 40       | 1-10
alchemy stone         | 45       | 1-4
magic crystal         | 50       | 1-4
pearl item            | 55       | 1-8
dye                   | 60       | 1-8
mount                 | 65       | 1-13
ship                  | 70       | 1-9
wagon                 | 75       | 1-6
furniture             | 80       | 1-9

## item grades

here's a list of item grades with their corresponding `grade` numbers as returned from the api.

grade (border color) | number (`grade`)
---------------------|-----------------
white                | 0
green                | 1
blue                 | 2
yellow               | 3
orange               | 4

## other info

auciel is the name of the central market director at old wisdom tree.

## stuff I don't know yet

- [ ] what is `chooseKey` on certain items?
- [ ] does `keyType` do anything?
- [ ] why does every item have an `isGodrAyed` property, even non-godr-ayeable items?
- [ ] can you get a list of every single item?
