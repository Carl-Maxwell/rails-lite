class CatsController < ControllerBase
  def index
    render_content(Cat.all.to_s, "text/text")
  end

  def new
  end

  def create
    Cat.create(params[:cat])
    
    redirect_to "/cats"
  end
end
