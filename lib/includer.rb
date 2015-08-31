require 'byebug'

# class Module
#   @original_module_const_missing = self.method(:const_missing)
#
#   def self.original_module_const_missing
#     @original_module_const_missing
#   end
#
#   def const_missing(sym)
#     load_success = false
#
#     [
#       "lib",
#       "app/controllers",
#       "app/helpers",
#       "app/models",
#       "config"
#     ].each do |folder|
#       if File.exists?("#{folder}/#{sym}")
#         load_success = load "#{folder}/#{sym}"
#
#         break if load_success
#       end
#     end
#
#     "loaded #{sym} via const_missing" if load_success
#
#     instance_eval(sym, &Module.original_module_const_missing) unless load_success
#   end
# end

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
