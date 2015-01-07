require 'faraday'

class HttpResource
	extend Forwardable

	def_delegators :@response, :status, :body

	def initialize(url)
		@full_url = "http://#{ url }"
		@response = Faraday.get @full_url
		puts @response
	end

	def to_s
		@full_url
	end
end

def http(url)
	HttpResource.new(url)
end