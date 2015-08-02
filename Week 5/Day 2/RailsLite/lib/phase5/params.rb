require 'uri'
require 'byebug'

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
      @params = {}
      parse_www_encoded_form(req.query_string) if req.query_string
      parse_www_encoded_form(req.body) if req.body
      @params.merge!(route_params) { |_, a, b| merger(a, b) }
    end

    def [](key)
      @params.with_indifferent_access[key.to_s]
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      URI::decode_www_form(www_encoded_form).each do |pair|
        keys = parse_key(pair.first)
        if keys.is_a?(Array)
          @params.merge!(build_chain(keys, pair[1])) { |_, v1, v2| merger(v1, v2) }
        else
          @params.merge!(keys[first] => pair[1])
        end
      end
    end

      def build_chain(arr, val)
      return val if arr.length < 1

      {arr.first => build_chain(arr.drop(1), val)}
      end

    def merger(v1, v2)
      return v1.merge(v2) {|k, a, b| merger(a, b)}
    end
    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
    key.split(/\]\[|\[|\]/)
    end
  end
end
