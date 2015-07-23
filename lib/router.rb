class Router
  attr_reader :routes

  def self.instance
    @instance ||= self.new
  end

  def initialize
    @routes = []
  end

  def add_route(pattern, method, controller_class, action_name)
    routes.push( Route.new(pattern, method, controller_class, action_name) )
  end

  def draw(&proc)
    self.instance_eval(&proc)
  end

  [:get, :post, :put, :patch, :delete].each do |http_method|
    define_method(http_method) do |pattern, controller_class, action_name|
      add_route(pattern, http_method, controller_class, action_name)
    end
  end

  def match(req)
    params = Params.new(req)

    if req.request_method == :post && params[:_method]
      req.request_method = params[:_method]
    end

    routes.find { |route| route.matches?(req) }
  end

  def run(req, res)
    route = match(req)
    if route
      route.run(req, res)
    else
      res.status = 404
    end
  end

  def resources(resource, options = {}, &nesting_blk)
  end

  def resource
  end

  class Route
    attr_reader :pattern, :http_method, :controller_class, :action_name

    def initialize(pattern, http_method, controller_class, action_name)
      @pattern          = pattern
      @http_method      = http_method
      @controller_class = controller_class
      @action_name      = action_name
    end

    def matches?(req)
      pattern =~ req.path && req.request_method == http_method
    end

    def run(req, res)
      route_params = pattern.match(req.path)

      route_params = route_params.names.zip(route_params.captures).to_h

      (controller_class.new(req, res, route_params)).invoke_action(action_name)
    end
  end
end
