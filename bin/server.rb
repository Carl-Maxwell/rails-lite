require 'webrick'

require_relative '../lib/includer.rb'

$cats = [
  { id: 1, name: "Curie" },
  { id: 2, name: "Markov" }
]

$statuses = [
  { id: 1, cat_id: 1, text: "Curie loves string!" },
  { id: 2, cat_id: 2, text: "Markov is mighty!" },
  { id: 3, cat_id: 1, text: "Curie is cool!" }
]

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  Router.instance.run(Request.new(req), res)
end

trap('INT') { server.shutdown }
server.start
