# Node class. Represents a node.
class Node
  def initialize(data)
    @data = data
    @next = nil
    @prev = nil
  end

  attr_accessor :data, :next, :prev
end
# Double linked list class. Represents a Doubly linked list.
class DLL
  def initialize
    @size = 0
    @head = nil
    @tail = nil
  end

  attr_accessor :size

  def remove(data)
    return 'The list is empty!' if @size == 0
    index = @head
    until index.nil
      if data == index.data
        # if the node to remove is at the head
        remove_from_beginning(index)
        # if the node to remove is at the end
        remove_from_end(index)
        # if the node is in the middle somewhere
        remove_from_middle(index)
      end
      index = index.next
    end
  end

  def insert(data)
    node = Node.new(data)
    if @size == 0
      @head, @tail = node
    else
      @head.prev = node
      node.next = @head
      @head = node
    end
    @size += 1
    "Node with data #{node.data} successfully added."
  end

  def rem_duplicates
    return 'The list is empty' if @head.nil?
    node = @head
    hash = Hash.new(0)
    until node.nil?
      hash[node.data] = true if hash[node.data] != true
      node = node.next
    end
    build_deduplicated_list(hash)
  end

  def to_s
    node = @head
    data = ''
    return 'The list is empty' if @head.nil?
    until node.nil?
      data += "#{node.data}, "
      node = node.next
    end
    data
  end

  def build_deduplicated_list(hash)
    key_array = hash.keys
    dll = DLL.new

    key_array.each do |data|
      dll.insert(data)
    end
    dll
  end

  def remove_from_beginning(index)
    if index.prev.nil?
      @head = index.next
      index.next = nil
      @size -= 1
      "Node with data #{index.data} successfully removed."
    end
  end

  def remove_from_end(index)
    return false unless index.next.nil?
    index.prev.next = nil
    index.prev = nil
    @size -= 1
    "Node with data #{index.data} successfully removed."
  end

  def remove_from_middle(index)
    index.next.prev = index.prev
    index.prev.next = index.next
    @size -= 1
    "Node with data #{index.data} successfully removed."
  end
end

# Test code
list = DLL.new
numbers = (1..100).to_a

200.times do
  list.insert numbers.sample
end

puts ''
puts 'Double Linked List with duplicates:'
puts list.to_s
puts ''
puts '------------------------------------------------------------------------'
puts ''
puts 'Double Linked List with duplicates removed:'
puts list.rem_duplicates.to_s
