require 'ebay/selling'
require 'ebay/model'

module Ebay


	def self.environment=(environment)
		unless["development","production"].include?(environment)
			raise(ArgumentError, "environment must be either development or production")
		end
		@environment = environment
	end
	def self.environment
		@environment || Rails.env
	end

	def self.ebay_headers
		{"X-EBAY-API-COMPATIBILITY-LEVEL" => "857",
		"X-EBAY-API-DEV-NAME" => config['dev_id'],
		"X-EBAY-API-APP-NAME" => config['app_id'],
		"X-EBAY-API-CERT-NAME" => config['cert_id'],
		"X-EBAY-API-SITEID" => "0",
		"Content-Type" => "text/xml"}
	end
	def self.auth_token
		config['auth_token']
	end
	def self.api_url
		config['uri']
	end

	def self.config
		YAML::load(File.open("config/config.yml"))[environment]
	end

end