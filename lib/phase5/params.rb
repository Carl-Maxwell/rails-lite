require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = parse_www_encoded_form(req.query_string)
      @params = @params.merge(parse_www_encoded_form(req.body))

      # ensure all keys are strings
      route_params = route_params.map { |k ,v| [k.to_s, v] }.to_h

      @params = @params.merge( route_params )
    end

    def [](key)
      params[key.to_s]
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      params.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    attr_reader :params

    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      return {} if www_encoded_form.nil? || www_encoded_form.empty?

      hash = {}

      URI::decode_www_form(www_encoded_form).each do |(keys, value)|
        keys = parse_key(keys)

        hash_dup = hash.dup
        inner_hash = hash_dup

        keys[0..-2].each do |key|
          inner_hash[key] ||= {}
          inner_hash = inner_hash[key]
        end

        inner_hash[ keys[-1] ] = value

        hash = hash.merge(hash_dup)
      end

      hash
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/[\[\]]+/)
    end

  end
end
