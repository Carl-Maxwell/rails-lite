require 'byebug'
require 'active_support/inflector'

module Phase2
  class ControllerBase
    attr_reader :req, :res

    # Setup the controller
    def initialize(req, res)
      @req = req
      @res = res
    end

    # Helper method to alias @already_built_response
    def already_built_response?
      !!@already_built_response
    end

    def do_not_rebuild_response
      raise "Already built response" if already_built_response?
      @already_built_response = true
    end

    # Set the response status code and header
    def redirect_to(url)
      do_not_rebuild_response

      res.status = 302
      res.reason_phrase = "REDIRECT"

      res["location"] = url
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, content_type)
      do_not_rebuild_response

      res.body = content
      res.content_type = content_type
    end
  end
end
