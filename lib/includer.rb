[
  "lib",
  "app/controllers",
  "app/helpers",
  "app/models",
  "config"
].each do |folder|
  Dir.glob(folder + "/*.rb").each do |rb_file|
    require_relative "../" + rb_file
  end
end
