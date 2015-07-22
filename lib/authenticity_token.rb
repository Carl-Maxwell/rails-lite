class AuthenticityToken
  class MissingAuthenticityTokenError < SecurityError; end;
  class InvalidAuthenticityTokenError < SecurityError; end;

  attr_reader :token

  def initialize(req)
    cookie = req.cookies.find { |cookie| cookie.name == self.class.cookie_name }
    @token = cookie ? cookie.value : self.class.generate_token
  end

  def store_token(res)
    res.cookies.push(WEBrick::Cookie.new(self.class.cookie_name, @token))
  end

  def self.cookie_name
    'authenticity_token'
  end

  def self.generate_token
    SecureRandom.urlsafe_base64(128)
  end

  def check_token(params)
    unless params[:authenticity_token]
      raise MissingAuthenticityTokenError
    end

    unless params[:authenticity_token] == @token
      raise InvalidAuthenticityTokenError
    end

    @token = self.class.generate_token
  end
end
