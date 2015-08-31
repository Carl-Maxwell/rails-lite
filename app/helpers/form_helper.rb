module FormHelper
  def authenticity_token_input
    <<-HTML
      <input
        type="hidden"
        name="authenticity_token"
        value="<%= form_authenticity_token %>"
      />
    HTML
  end
end
