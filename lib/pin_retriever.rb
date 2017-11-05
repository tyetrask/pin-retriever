require 'cgi'
require 'fileutils'
require 'open-uri'
require 'lib/pinterest/pinterest_api_client'

class PinRetriever

  def initialize(access_token, output_path)
    @access_token = access_token
    @pinterest_api = PinterestAPIClient::V1.new(@access_token)
    @output_path = output_path
    @me = nil
  end

  def download_pin_images!
    validate_output_path!
    validate_access_token!
    @boards = @pinterest_api.me_boards.body["data"]
    puts "Found #{@boards.size} board(s)"
    @boards.each do |board|
      @pins = @pinterest_api.board_pins(board["id"]).body["data"]
      FileUtils.mkdir("#{@output_path}/#{board["name"]}")
      puts "Found #{@pins.size} pins(s) for this board"
      @pins.each do |pin|
        source_url = pin["image"]["original"]["url"]
        destination_file_extension = File.extname(source_url)
        destination_path = "#{@output_path}/#{board["name"]}/#{pin["id"]}#{destination_file_extension}"
        download_image(source_url, destination_path)
      end
    end
  end

  private

  def validate_output_path!
    raise "Output path does not exist" unless File.exist?(@output_path)
  end

  def validate_access_token!
    response = @pinterest_api.me
    raise "Could not access Pinterest API" unless response.status == 200 && response.body["data"]["id"]
    @me = response.body["data"]
  end

  def download_image(source_url, destination_path)
    open(source_url) do |remote_file|
       File.open(destination_path, "wb") do |local_file|
         local_file.puts remote_file.read
       end
    end
  end

end
