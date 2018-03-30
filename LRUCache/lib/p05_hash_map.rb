require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    key_bucket = bucket(key)
    delete(key) if key_bucket.include?(key)
    key_bucket.append(key,val)
    @count += 1
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  include Enumerable

  def each(&block)
    @store.each { |bucket| bucket.each { |node| block.call(node.key, node.val) } }
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    # temp_count = count
    # if count == num_buckets
    #   temp_store = []
    #   self.each { |k,v| }
    #   @store = Array.new(num_buckets * 2) { LinkedList.new }
    # end
    # @count = temp_count
  end

  def bucket(key)
    @store[key.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `key`
  end
end
