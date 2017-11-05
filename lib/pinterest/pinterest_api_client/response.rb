class PinterestAPIClient
  class Response

    attr_accessor :status, :body

    def initialize(response)
      @status = response.code.to_i
      begin
        @body = JSON.parse(response.body)
      rescue StandardError => error
        @body = {errors: ["Could not parse response body"]}
      end
    end

  end
end
