require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    def initialize(req, route_params = {})
        query = req.query_string || ""
        @params ||= {}
        @params = parse_www_encoded_form(query)
        @params = @params.merge(route_params)
        unless req.body.nil?
            body = req.body.split("&").map!{|a| a.split("=")} 
            @params = @params.merge(parse_body(body))
        end       
    end

    def [](key)
        @params
        @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
        hash = {}
        decoded = URI::decode_www_form(www_encoded_form)
        decoded.each do |arr|
            key, value = arr[0], arr[1]
            keys = parse_key(key)
            hash = hash.merge(generate_nested_hash(keys+[value])) 
        end
        hash
    end

    def parse_body(body)
        hash={}
        body.each do |arr|
            key, value = arr[0], arr[1]
            keys = parse_key(key)
            hash = hash.merge(generate_nested_hash(keys+[value]))
        end
        hash 
    end

    def generate_nested_hash(arr)
        return arr.first if arr.length == 1
        return {arr.shift => generate_nested_hash(arr[0..-1])} 
    end


    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
        array = key.split(/\]\[|\[|\]/)
    end
  end
end
