require 'json'
require 'webrick'

module Phase4
  class Session
    attr_accessor :store

    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      cookie = req.cookies.find { |cookie| cookie.name == '_rails_lite_app' }

      self.store = cookie ? JSON.load(cookie.value) : {}
    end

    def [](key)
      store[key]
    end

    def []=(key, val)
      store[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies.push( WEBrick::Cookie.new('_rails_lite_app', store.to_json) )
    end
  end
end
