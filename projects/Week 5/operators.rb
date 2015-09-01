def swap(x, y)
  #in-place, one-liner
  #x = [y, y = x][0]
  #XOR method / correct answer
  x = x ^ y
  y = x ^ y
  x = x ^ y
  puts "#{x}, #{y}" # <== should be reversed from your input
end

class String
  def XOR(other_string)
    xor = ""
    other_string.each_char.with_index do |char, i|
      if self[i]
        char == self[i] ? xor << "0" : xor << "1"
      else
        xor << char
      end
    end
    xor << self.slice(other_string.length, self.length) if self.length > other_string.length

    xor
  end

  def LSHIFT(num)
    num = length if num > self.length
    shifted = self[num, self.length]
    num.times { shifted << "0" }
    shifted
  end
end

def is_power_of_two(num)
  binary = num.to_s(2).to_i
  rep = binary.to_s
  return true if binary == 1
  return (binary % (10 ** ( rep.length - 1 )) == 0)
end

def twos_complement(binary_num_string)
  complement = ""
  mirror = ~binary_num_string.to_i(2) + 1
  puts "mirror: #{mirror}"
  (binary_num_string.length - 1).downto(0) { |n| complement << mirror[n].to_s }

  complement
end
