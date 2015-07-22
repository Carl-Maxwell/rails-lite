require 'uri'

class Params
  def initialize(req, route_params = {})
    @params = parse_www_encoded_form(req.query_string)
    @params.merge!( parse_www_encoded_form(req.body) )
    @params.merge!( route_params )

    # ensure all keys are symbols, recursively

    @params = recursively_to_sym_hash(@params)
  end

  def [](key)
    params[key.to_s.to_sym]
  end

  def to_s
    params.to_s
  end

  class AttributeNotFoundError < ArgumentError; end;

  private
  attr_reader :params

  def parse_www_encoded_form(www_encoded_form)
    return {} if www_encoded_form.nil? || www_encoded_form.empty?

    hash = {}

    URI::decode_www_form(www_encoded_form).each do |(keys, value)|
      keys = parse_key(keys)

      hash_dup = hash.dup
      inner_hash = hash_dup

      keys[0...-1].each do |key|
        inner_hash[key] ||= {}
        inner_hash = inner_hash[key]
      end

      inner_hash[ keys[-1] ] = value

      hash = hash.merge(hash_dup)
    end

    hash
  end

  def parse_key(key)
    key.split(/[\[\]]+/)
  end

  private

  def recursively_to_sym_hash(hash)
    return hash unless hash.is_a?(Hash)

    hash.map { |k ,v| [k.to_s.to_sym, recursively_to_sym_hash(v)] }.to_h
  end
end
