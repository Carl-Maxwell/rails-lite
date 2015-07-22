class CatsController < ControllerBase
  def index
    render_content($cats.to_s, "text/text")
  end

  def new
  end

  def create
    $cats << params[:cat].map { |k,v| [k.to_s.to_sym, v] }.to_h.merge($cats.max(:id))
    redirect_to "/cats"
  end
end
