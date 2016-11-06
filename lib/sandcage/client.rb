require "certifi"
require "httparty"

module Sandcage
  API_ROOT = "https://api.sandcage.com/"
  API_VERSION = "0.2"

  class Client
    TIMEOUT = 30
    include HTTParty
    
    # Default connection adapter options
    # Specify CA certificate location, which also sets
    # http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    # see https://github.com/jnunemaker/httparty/blob/master/lib/httparty/connection_adapter.rb
    ssl_ca_file Certifi.where
    default_timeout TIMEOUT
    headers "User-Agent" => "SandCage - #{Sandcage::API_VERSION}"

    # Give your SandCage API Key as a constructor parameter
    # This can be retrieved from https://www.sandcage.com/panel/api_key
    def initialize(api_key=nil)
      @api_key = api_key
      @sandcage_api_endpoint = "#{Sandcage::API_ROOT}/#{Sandcage::API_VERSION}/"
    end
    
    # The call_endpoint method.
    # This method sends http request to the endpoint.
    #
    # First parameter "endpoint" (string) is the url of the endpoint.
    # Second parameter "post" (boolean) indicates the http method type.
    # true => POST
    # false => GET
    # Third parameter "data" (hash) is the data to be sent.
    # Method's return type is HTTParty::Response object.
    def call_endpoint(endpoint, post=false, data=nil)
      if post
        r = self.class.post(endpoint, body: data.to_json)
      else
        r = self.class.get(endpoint)
      end
    end

    # The "get-info" service
    #
    # First parameter "payload" (hash) contains the data to be sent.
    # Method's return type is HTTParty::Response object.
    def get_info_service(payload=nil)
      call_endpoint("#{@sandcage_api_endpoint}get-info",
                    post=true,
                    data=get_post_data(payload))
    end
    
    # The "list-files" service
    #
    # First parameter "payload" (dictionary) contains the data to be sent.
    # Method's return type is HTTParty::Response object.
    def list_files_service(payload=nil)
      call_endpoint("#{@sandcage_api_endpoint}list-files",
                    post=true,
                    data=get_post_data(payload))
    end
    
    # The "destroy-files" service
    # 
    # First parameter "payload" (hash) contains the data to be sent.
    # Second parameter "callback_endpoint" (string) is the url, where the 
    # callback should be send to.
    # Method's return type is HTTParty::Response object.
    def destroy_files_service(payload=nil, callback_endpoint=nil)
      data = get_post_data(payload)
      update_callback data, callback_endpoint
      call_endpoint("#{@sandcage_api_endpoint}destroy-files",
                    post=true,
                    data=data)
    end

    # The "schedule-tasks" service
    #
    # First parameter "payload" (hash) contains the data to be sent.
    # Second parameter "callback_endpoint" (string) is the url, where the 
    # callback should be send to.
    # Method's return type is HTTParty::Response object.
    def schedule_files_service(payload=nil, callback_endpoint=nil)
      data = get_post_data(payload)
      update_callback data, callback_endpoint
      call_endpoint("#{@sandcage_api_endpoint}schedule-tasks",
                    post=true,
                    data=data)
    end

    private
    
    # Combine payload with API KEY and return the dictionary.
    def get_post_data(payload=nil)
      d = { key: @api_key }
      if payload
        d.update payload
      end
      return d
    end
    
    # Update data with callback_endpoint address.
    def update_callback(data, callback_endpoint=nil)
      if callback_endpoint
        data[:callback_endpoint] = callback_endpoint
      end
    end
  end
end
