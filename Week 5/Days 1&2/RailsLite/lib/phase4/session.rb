require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      cookie = req.cookies.select {|cookie| cookie.name == '_rails_lite_app'}
      cookie.empty? ? @sesh = {} : @sesh = JSON.parse(cookie.first.value)
    end

    def [](key)
      @sesh[key]
    end

    def []=(key, val)
      @sesh[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      if res.cookies.any? {|cookie| cookie.name == '_rails_lite_app'}
        res.cookies.map {|cookie| cookie.value = @sesh.to_json if cookie.name = '_rails_lite_app'}
      else
        res.cookies << WEBrick::Cookie.new("_rails_lite_app", @sesh.to_json)
      end
    end
  end
end
