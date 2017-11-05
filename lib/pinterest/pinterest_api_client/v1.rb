require 'net/https'
require 'uri'
require 'json'
require_relative 'response.rb'

class PinterestAPIClient
  class V1

    BASE_URL = 'https://api.pinterest.com/v1'

    def initialize(access_token)
      @access_token = access_token
    end

    def me
      url = "/me/#{query_string}"
      get_request(url)
    end

    def board(board_id)
      url = "/boards/#{board_id}/#{query_string}"
      get_request(url)
    end

    def me_boards
      url = "/me/boards/#{query_string}"
      get_request(url)
    end

    def pin(pin_id)
      url = "/pins/#{pin_id}/#{query_string}"
      get_request(url)
    end

    def me_pins
      url = "/me/pins/#{query_string}"
      get_request(url)
    end

    def board_pins(board_id)
      query_options = {fields: "id,image"}
      url = "/boards/#{board_id}/pins/#{query_string(query_options)}"
      get_request(url)
    end

    private

    def get_request(path)
      uri = URI.parse("#{BASE_URL}#{path}")
      request = Net::HTTP.new(uri.host, uri.port)
      request.use_ssl = true
      Response.new(request.get(uri.request_uri))
    end

    def query_string(query_object={})
      query_object_with_auth = query_object.merge({
        access_token: @access_token
      })
      "?#{URI.encode_www_form(query_object_with_auth)}"
    end

  end
end
