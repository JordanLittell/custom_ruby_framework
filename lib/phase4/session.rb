require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
        req.cookies.each do |cookie|
            @cookie_value = JSON.parse(cookie.value) if cookie.name == '_rails_lite_app'
        end
        @cookie_value ||= {}
    end

    def [](key)
        @cookie_value[key]
    end

    def []=(key, val)
        @cookie_value[key.to_sym] = val 
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
        cookie = WEBrick::Cookie.new('_rails_lite_app', @cookie_value.to_json)
        res.cookies << cookie 
    end
  end
end
