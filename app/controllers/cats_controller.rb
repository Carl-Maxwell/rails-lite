class CatsController < ControllerBase
  def index
    @cats = Cat.all
  end

  def new
    @cat = Cat.new
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def create
    Cat.create(params[:cat])

    redirect_to "/cats"
  end
end
