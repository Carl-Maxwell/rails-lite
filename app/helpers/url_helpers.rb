module UrlHelper
  def method_missing(name, *args, &block)
    if name.to_s.end_with?("_url")
      thing = /([\w]+)_url$/.match(name.to_s)[1]
      obj = args[0]

      if thing.start_with?('edit_')
        thing = thing[5..-1]
        if thing != thing.pluralize && obj.is_a?(SQLObject)
          "/#{thing.pluralize}/#{obj.parameterize}/edit"
        end
      elsif thing != thing.pluralize && obj.is_a?(SQLObject)
        "/#{thing.pluralize}/#{obj.parameterize}"
      elsif thing.start_with?("new_")
        "/#{thing[4..-1]}/new"
      elsif thing = thing.pluralize
        "/#{thing}"
      end
    else
      super
    end
  end
end
