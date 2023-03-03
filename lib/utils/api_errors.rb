# frozen_string_literal: true

# contains all the errors the api can return.
module ApiErrors
  UNEXPECTED_BLACK_DESERT_RESPONSE = {
    error: 'the black desert api returned an unexpected value. please report this to jpegzilla.'
  }.freeze.to_json
end
