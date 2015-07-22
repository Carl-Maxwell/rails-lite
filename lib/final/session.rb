require 'json'
require 'webrick'

class Session
  attr_accessor :store

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

  def store_session(res)
    res.cookies.push( WEBrick::Cookie.new('_rails_lite_app', store.to_json) )
  end
end
