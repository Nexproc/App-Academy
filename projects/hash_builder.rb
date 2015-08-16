def hash_builder(arr)
  arr.each do |pair|
    keys = pair.first
    if keys.is_a?(Array)
      $params.merge!(build_chain(keys, pair[1])) { |_, v1, v2| merger(v1, v2) }
    else
      $params[keys] = pair[1]
    end
  end
end

def build_chain(arr, val)
  return val if arr.length < 1
  a = {}
  new_link = build_chain(arr.drop(1), val)
  if $params[arr.first]
    $params[arr.first].merge!(new_link)
    return nil
  end
  return {arr.first => new_link} if new_link && !$params[arr.first]
end

def merger(v1, v2)
    v1.merge(v2) {|_, a, b| merger(a, b)}
end

def hashify(hash, keys, value) # keys is an array,
  first = keys.first
  if keys.length == 1
    hash.merge!({first => value})
  else
    hash[first] ||= {}
    hash[first].merge!(hashify(hash[first], keys.drop(1), value))
  end
  hash
end
