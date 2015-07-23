Router.instance.draw do
  #
  # resources :cats
  #

  get   Regexp.new("^/cats$"),                  CatsController, :index
  get   Regexp.new("^/cats/(?<id>\\d+)$"),      CatsController, :show

  get   Regexp.new("^/cats/new$"),              CatsController, :new
  post  Regexp.new("^/cats$"),                  CatsController, :create

  get   Regexp.new("^/cats/(?<id>\\d+)/edit$"), CatsController, :edit
  patch Regexp.new("^/cats/(?<id>\\d+)$"),      CatsController, :update

  delete Regexp.new("^/cats/(?<id>\\d+)$"),     CatsController, :update

  #
  # resources :statuses, only: [:index] (also nested within cat)
  #

  get  Regexp.new("^/cats/(?<cat_id>\\d+)/statuses$"), StatusesController, :index
end
