require 'webrick'

# require all the things

[
  "lib",
  "app/controllers",
  "app/helpers",
  "app/models",
  "config"
].each do |folder|
  Dir.glob(folder + "/*.rb").each do |rb_file|
    require_relative "./../" + rb_file
  end
end

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
  Router.instance.run(req, res)
end

trap('INT') { server.shutdown }
server.start
