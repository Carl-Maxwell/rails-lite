module LinkTo
  def link_to(value, href)
    if href.is_a?(SQLObject)
      controller = href.class.to_s.underscore.pluralize
      id         = href.id

      href = "/#{controller}/#{id}"
    end

    "<a href=\"#{href}\">#{value}</a>"
  end
end
