module HtmlSafe
  HTML_ESCAPE = { '&' => '&amp;', '>' => '&gt;', '<' => '&lt;', '"' => '&quot;', "'" => '&#39;' }

  def html_escape(str)
    str.chars.map { |l| HTML_ESCAPE[l] || l }.join("")
  end
end
