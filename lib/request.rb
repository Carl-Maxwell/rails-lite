class Request
  # this is a delegator for the WEBrick request object

  def initialize(delegated)
    @delegated = delegated
  end

  def request_method
    (@request_method || super).to_s.downcase.to_sym
  end

  def request_method=(value)
    @request_method = value
  end

  def path
    path = super

    path[-1] == '/' ? path[0...-1] : path
  end

  def method_missing(name, *args, &block)
    if @delegated.respond_to?(name)
      @delegated.send(name, *args, &block)
    else
      super
    end
  end

end
