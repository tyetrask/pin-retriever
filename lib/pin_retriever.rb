require 'lib/pinterest/pinterest_api_client'

class PinRetriever

  def initialize(access_token, output_path)
    @access_token = access_token
    @pinterest_api = PinterestAPIClient::V1.new(@access_token)
    @output_path = output_path
  end

  def download_pin_images!
    validate_output_path!
    validate_access_token!
    # TODO
  end

  private

  def validate_output_path!
    raise "Output path does not exist" unless File.exist?(@output_path)
  end

  def validate_access_token!
    response = @pinterest_api.me
    raise "Could not access Pinterest API" unless response.status == 200 && response.body["data"]["id"]
  end

end
