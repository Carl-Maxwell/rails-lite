require 'byebug'
require 'active_support/inflector'

require 'active_support'
require 'active_support/core_ext'
require 'erb'

require_relative 'session'
require_relative 'flash'
require_relative 'params'
require_relative 'authenticity_token'

class ControllerBase
  attr_reader :req, :res, :params

  def initialize(req, res, route_params = {})
    @req    = req
    @res    = res
    @params = Params.new(req, route_params)
    @authenticity_token = AuthenticityToken.new(req)

    if req.request_method.downcase.to_sym != :get
      @authenticity_token.check_token(params)
    end
  end

  def session
    @session ||= Session.new(req)
  end

  def flash
    @flash ||= Flash.new(req)
  end

  def form_authenticity_token
    @authenticity_token.token
  end

  def already_built_response?
    !!@already_built_response
  end

  def do_not_rebuild_response
    raise "Already built response" if already_built_response?
    @already_built_response = true
  end

  def render(template)
    controller = self.class.to_s.underscore
    template = File.read("views/#{controller}/#{template}.html.erb")

    render_content(ERB.new(template).result(binding), "text/html")
  end

  def invoke_action(name)
    self.send(name)
    unless already_built_response?
      render name
    end
  end

  def redirect_to(url)
    do_not_rebuild_response

    res.status = 302
    res["location"] = url

    session.store_session(res)
    flash.store_flash(res)
    @authenticity_token.store_token(res)
  end

  def render_content(content, content_type)
    do_not_rebuild_response

    res.body = content
    res.content_type = content_type

    session.store_session(res)
    flash.store_flash(res)
    @authenticity_token.store_token(res)
  end
end
