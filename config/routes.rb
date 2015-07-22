router = Router.new
router.draw do
  get  Regexp.new("^/cats$"), CatsController, :index
  post Regexp.new("^/cats$"), CatsController, :create
  get  Regexp.new("^/cats/new$"), CatsController, :new
  get  Regexp.new("^/cats/(?<cat_id>\\d+)/statuses$"), StatusesController, :index
end