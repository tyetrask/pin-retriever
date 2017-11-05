require 'net/https'
require 'uri'
require 'json'
require_relative 'response.rb'

class PinterestAPIClient
  class V1

    BASE_URL = 'https://api.pinterest.com/v1/'

    def initialize(access_token)
      @access_token = access_token
    end

    def me
      query_options = {fields: "id,first_name"}
      url = "#{BASE_URL}me/#{query_string(query_options)}"
      get_request(url)
    end

    # Board ID Format: <username>/<board_name>
    def board(board_id)
      query_options = {fields: "id,name,counts"}
      url = "#{BASE_URL}boards/#{board_id}/#{query_string(query_options)}"
      get_request(url)
    end

    def me_boards
      query_options = {fields: "id,name,counts"}
      url = "#{BASE_URL}me/boards/#{query_string(query_options)}"
      get_request(url)
    end

    def pin(pin_id)
      query_options = {fields: "id"}
      url = "#{BASE_URL}pins/#{pin_id}/#{query_string(query_options)}"
      get_request(url)
    end

    def me_pins
      query_options = {fields: "id"}
      url = "#{BASE_URL}me/pins/#{query_string(query_options)}"
      get_request(url)
    end

    def board_pins(board_id)
      query_options = {fields: "id"}
      url = "#{BASE_URL}me/boards/#{board_id}/pins/#{query_string(query_options)}"
      get_request(url)
    end

    private

    def get_request(url)
      uri = URI.parse(url)
      request = Net::HTTP.new(uri.host, uri.port)
      request.use_ssl = true
      response = request.get(uri.request_uri)
      Response.new(response)
    end

    def query_string(query_object={})
      query_object_with_auth = query_object.merge({
        access_token: @access_token
      })
      "?#{URI.encode_www_form(query_object_with_auth)}"
    end

  end
end
