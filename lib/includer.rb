require 'byebug'

class Includer
  def self.instance
    @instance ||= self.new
  end

  def initialize
    @included_stuff = []
  end

  attr_accessor :included_stuff

  def go
    [
      "lib",
      "app/controllers",
      "app/helpers",
      "app/models",
      "config"
    ].each do |folder|
      Dir.glob(folder + "/*.rb").each do |rb_file|
        next if included_stuff.include?("./" + rb_file)

        require "./" + rb_file
        included_stuff << rb_file
      end
    end
  end
end

Includer.instance.go
