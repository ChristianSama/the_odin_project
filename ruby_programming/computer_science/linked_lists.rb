class Node
  attr_accessor :value, :next_node
  def initialize(value: nil, next_node: nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_accessor :head
  def initialize
    @head = nil
  end

  def append(value)
    if (@head == nil)
      @head = Node.new(value: value)
    else
      tmp = @head
      while (tmp.next_node != nil)
        tmp = tmp.next_node
      end
      tmp.next_node = Node.new(value: value)
    end
  end

  def prepend(value)
      @head = Node.new(value: value, next_node: @head)
  end

  def size
    counter = 0
    if (@head != nil)
      tmp = @head
      while (tmp != nil)
        tmp = tmp.next_node
        counter += 1
      end
    end
    counter
  end

  def tail
    tmp = @head
    loop do
      return tmp if tmp.next_node == nil
      tmp = tmp.next_node
    end
  end

  def at(index)
    i = 0
    tmp = @head
    while (i < index)
      tmp = tmp.next_node
      break if tmp == nil
      i += 1
    end
    tmp
  end

  def pop
    if (@head == nil)
      return
    elsif (@head.next_node == nil)
      @head = nil
    else
      prev = @head
      cur = @head.next_node
      while cur.next_node != nil
        prev = cur
        cur = cur.next_node
      end
      prev.next_node = nil
    end
  end

  def contains?(value)
    tmp = @head
    until (tmp == nil)
      return true if tmp.value == value
      tmp = tmp.next_node
    end
    return false
  end

  def find(value)
    i = 0
    tmp = @head
    until (tmp == nil)
      return i if tmp.value == value
      tmp = tmp.next_node
      i += 1
    end
    nil
  end

  def to_s
    tmp = @head
    until (tmp == nil)
      print "( #{tmp.value} ) -> "
      tmp = tmp.next_node
    end
    print "nil\n" if tmp == nil
  end

  def insert_at(value, index)
    cur = @head
    if (index == 0)
      prepend(value)
    else
      i = 1
      until (cur == nil)
        if i == index
          cur.next_node = Node.new(value: value, next_node: cur.next_node)
          return
        end
        cur = cur.next_node 
        i += 1
      end
      nil
    end
  end

  def remove_at(index)
    return if @head == nil
    if index == 0
      if @head.next_node == nil
        @head = nil
        return
      end
      @head = @head.next_node
      return
    end
    i = 1
    prev = @head
    cur = @head.next_node
    while (cur != nil)      
      if (i == index)
        prev.next_node = cur.next_node
        return
      end
      prev = cur
      cur = cur.next_node
      i += 1
    end
  end
end



list = LinkedList.new();
list.head = Node.new(value: "0 / head");
list.head.next_node = Node.new(value: "1");
list.head.next_node.next_node = Node.new(value: "2");
list.append("3")
list.append("4")

# p list.size
# p list.tail.value
#p list.contains?("4")

#list.find("5")
list.to_s
list.remove_at(5)
list.to_s

#puts list.head.value
#puts list.head.next_node.value
# puts list.head.next_node.next_node.value
# puts list.head.next_node.next_node.next_node.value
# puts list.head.next_node.next_node.next_node.next_node.value

#list.pop

#puts list.head.value
#puts list.head.next_node
# puts list.head.next_node.next_node.value
# puts list.head.next_node.next_node.next_node.value
# puts list.head.next_node.next_node.next_node.next_node.value

# p list.at(4).value