class Node
  def initialize(data)
    @data = data
    @next = nil
    @prev = nil
  end

  attr_accessor :data, :next, :prev

end


class DLL

  def initialize ()
    @size = 0
    @head = nil
    @tail = nil
  end

  attr_accessor :size

  def remove(data)
    return "The list is empty!" if @size == 0
    index = @head
    while index != nil
      if data == index.data
        # if the node to remove is at the head
        if index.prev == nil
          @head = index.next
          index.next = nil
          @size -= 1
          return "Node with data #{index.data} successfully removed."
        end
        #if the node to remove is at the end
        if index.next == nil
          index.prev.next = nil
          index.prev = nil
          @size -= 1
          return "Node with data #{index.data} successfully removed."
        end
        #if the node is in the middle somewhere
        index.next.prev = index.prev
        index.prev.next = index.next
        @size -= 1
        return "Node with data #{index.data} successfully removed."
      end
      index = index.next
    end
  end

  def insert(data)
    node = Node.new(data)
    if @size == 0
      @head = node
      @tail = node
    else
      @head.prev = node
      node.next = @head
      @head = node
    end
    @size += 1
    return "Node with data #{node.data} successfully added."
  end

  def rem_duplicates
    return 'The list is empty' if @head == nil

    node = @head
    hash = Hash.new(0)
    while node != nil do
      hash[node.data] = true if hash[node.data] != true
      node = node.next
    end

    key_array = hash.keys
    dll = DLL.new

    key_array.each do |data|
      dll.insert(data)
    end

    return dll

  end

  def to_s
    node = @head
    data = ''
    return 'The list is empty' if @head == nil
    while node != nil do
      data = data + "#{node.data}, "
      node = node.next
    end
    return data
  end

end


#Test code
list = DLL.new
numbers = (1..100).to_a

200.times do
list.insert numbers.sample
end

puts ''
puts 'Double Linked List with duplicates:'
puts list.to_s
puts ''
puts'--------------------------------------------------------------------------'
puts ''
puts 'Double Linked List with duplicates removed:'
puts list.rem_duplicates.to_s


