module LinkTo
  def link_to(value, href)
    if href.is_a?(SQLObject)
      controller = href.class.to_s.underscore.pluralize
      id         = href.id

      href = "/#{controller}/#{id}"
    end

    "<a href=\"#{href}\">#{value}</a>"
  end

  def button_to(value, href, options)
    options = {
      method: :post
    }.merge(options)

    <<-HTML
    <form action="#{href}" method="POST">
      <input type="hidden" name="_method" value="#{options[:method]}" />
      #{authenticity_token_input}
      <input type="submit" value="#{value}" />
    </form>
    HTML
  end
end
