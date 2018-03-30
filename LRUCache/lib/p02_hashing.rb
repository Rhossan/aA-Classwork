require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 78 if self.empty?
    hash_arr = self.map.with_index { |el, idx| el.hash * idx.hash }
    hash_arr.reduce(0, :+)
  end
end

class String
  def hash
    hash_arr = self.chars.map.with_index { |chr, idx| chr.ord.hash * idx.hash }
    hash_arr.reduce(:+)
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end
