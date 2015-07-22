require 'json'

class Flash
  attr_reader :now, :later

  def initialize(req)
    cookie = req.cookies.find { |cookie| cookie.name == 'flash' }

    @later = {}

    begin
      @now = cookie ? JSON.load(cookie.value) : {}
    rescue JSON::ParserError
      puts "Flash: JSON parser error"
      @now = {}
    end
  end

  def now
    @now
  end

  def later
    @later
  end

  def [](key)
    now[key.to_s.to_str] || now[key.to_s.to_sym]
  end

  def []=(key, value)
    later[key] = value
  end

  def store_flash(res)
    res.cookies.push( WEBrick::Cookie.new('flash', later.to_json) )
  end
end
