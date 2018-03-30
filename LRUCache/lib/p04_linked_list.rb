require 'byebug'
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  attr_reader  :head, :tail
  def initialize
    @head = Node.new
    @tail = Node.new
    head.next = tail
    tail.prev = head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail
  end

  def get(key)
    pointer = find(key)
    pointer == tail ? nil : pointer.val
  end

  def include?(key)
    find(key) != tail
  end

  def append(key, val)
    e = Node.new(key, val)
    e.next = tail
    e.prev = tail.prev
    e.prev.next = e
    tail.prev = e
  end


  def update(key, val)
    pointer = find(key)
    return nil if pointer == tail
    pointer.val = val
  end

  def remove(key)
    # debugger
    pointer = find(key)
    return nil if pointer == tail
    pointer.next.prev = pointer.prev
    pointer.prev.next = pointer.next
  end

  include Enumerable
  def each(&blk)
    pointer = first
    until pointer == tail
      blk.call(pointer)
      pointer = pointer.next
    end
    self
  end

  def find(key)
    node = head
    node = node.next until node.key == key || node == tail
    node
  end
  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
