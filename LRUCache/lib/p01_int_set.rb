class MaxIntSet
  attr_reader :store, :max
  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end
    
  def insert(num)
    is_valid?(num)
    store[num] = true
  end

  def remove(num)
    is_valid?(num)
    store[num] = false
  end

  def include?(num)
    store[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num >= max || num < 0
    true
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)    
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      resize! if count == num_buckets
      self[num] << num 
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num) 
      @count -= 1
    end 
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    storage = store.flatten
    @store = Array.new(num_buckets * 2) {Array.new}
    temp_count = count
    storage.each {|el| insert(el)}
    @count = temp_count
    
  end
end
