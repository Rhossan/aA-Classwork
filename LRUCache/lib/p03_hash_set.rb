require_relative 'p02_hashing'
require_relative 'p01_int_set'

class HashSet < ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  # def insert(key)
  #   unless include?(key)
  #     resize! if count == num_buckets
  #     self[key_hash(key)] << key
  #     @count += 1
  #   end
  # end
  #
  # def include?(key)
  #   self[key_hash(key)].include?(key)
  # end
  #
  # def remove(key)
  #   if include?(key)
  #     self[key_hash(key)].delete(key)
  #     @count -= 1
  #   end
  # end

  private

  def key_hash(key)
    key.hash
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end
  #
  # def num_buckets
  #   @store.length
  # end
  #
  def resize!
    temp_store = []
    temp_count = count
    @store.each { |bucket| bucket.each { |el| temp_store << el } }
    @store = Array.new(num_buckets * 2) { Array.new }
    temp_store.each { |el| insert(el) }
    @count = temp_count
  end
end
