require 'webrick'
# require_relative '../lib/phase6/controller_base'
# require_relative '../lib/phase6/router'

require_relative '../lib/final/controller_base'
require_relative '../lib/final/router'

$cats = [
  { id: 1, name: "Curie" },
  { id: 2, name: "Markov" }
]

$statuses = [
  { id: 1, cat_id: 1, text: "Curie loves string!" },
  { id: 2, cat_id: 2, text: "Markov is mighty!" },
  { id: 3, cat_id: 1, text: "Curie is cool!" }
]

class StatusesController < ControllerBase
  def index
    statuses = $statuses.select do |s|
      s[:cat_id] == Integer(params[:cat_id])
    end

    render_content(statuses.to_s, "text/text")
  end
end

class CatsController < ControllerBase
  def index
    render_content($cats.to_s, "text/text")
  end

  def new
  end

  def create
    $cats << params[:cat].map { |k,v| [k.to_s.to_sym, v] }.to_h.merge($cats.max(:id))
    redirect_to "/cats"
  end
end

router = Router.new
router.draw do
  get  Regexp.new("^/cats$"), CatsController, :index
  post Regexp.new("^/cats$"), CatsController, :create
  get  Regexp.new("^/cats/new$"), CatsController, :new
  get  Regexp.new("^/cats/(?<cat_id>\\d+)/statuses$"), StatusesController, :index
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  route = router.run(req, res)
end

trap('INT') { server.shutdown }
server.start
