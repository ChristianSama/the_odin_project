class Node
  #include Comparable
  attr_accessor :data, :right, :left
  # def <=>(other)
  #   data <=> other.data
  # end
  def initialize (data: nil, right: nil, left: nil)
    @data = data
    @right = right
    @left = left
  end
end

class Tree
  attr_accessor :root
  def initialize(arr)
    @arr = arr.uniq.sort
    @root = build_tree(@arr)
  end

  def build_tree(arr)
    if (arr.empty?)
      return nil
    end
    mid = arr.length/2
    root = Node.new(data:arr[mid])
    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[mid+1..-1])
    return root
  end

  def insert(cur = @root, val)
    return Node.new(data: val) if cur == nil
    if (cur.data == val)
      return cur
    elsif (cur.data < val)
      cur.right = insert(cur.right, val)
    else
      cur.left = insert(cur.left, val)
    end
    cur
  end

  def delete(cur = @root, val)
    return cur if cur == nil
    if val < cur.data
      cur.left = delete(cur.left, val)
    elsif (val > cur.data)
      cur.right = delete(cur.right, val)
    else
      if cur.left == nil
        temp = cur.right
        cur = nil
        return temp
      elsif cur.right == nil
        temp = cur.left
        cur = nil
        return temp
      end
      temp = minValueNode(cur.right)
      cur.data = temp.data
      cur.right = delete(cur.right, temp.data)
    end
    cur
  end

  def minValueNode(node)
    cur = node
    while (cur.left != nil)
      cur = cur.left
    end
    cur
  end

  def find(val) #iterative solution
    cur = @root
    until (val == cur.data)
      puts cur.data
      if (val < cur.data)
        cur = cur.left
      else
        cur = cur.right
      end 
    end
    cur
  end

  def level_order(node = @root)
    return if node == nil
    result = []
    q = []
    q.push(node)
    while (!q.empty?)
      cur = q.first
      result.push(cur.data)
      if (cur.left != nil)
        q.push(cur.left)
      end
      if (cur.right != nil)
        q.push(cur.right)
      end
      q.shift
    end
    result
  end

  def inorder(root = @root, result = [])
    if (root != nil)
      inorder(root.left, result)
      result.push(root.data)
      inorder(root.right, result)
    end
    result
  end

  def preorder(root = @root, result = [])
    if (root != nil)
      result.push(root.data)
      preorder(root.left, result)
      preorder(root.right, result)
    end
    result
  end

  def postorder(root = @root, result = [])
    if (root != nil)
      postorder(root.left, result)
      postorder(root.right, result)
      result.push(root.data)
    end
    result
  end

  def height(node = @root)
    return -1 if node == nil
    left_tree = height(node.left)
    right_tree = height(node.right)
    return ([left_tree, right_tree].max) +1
  end

  def balanced?(node = @root)
    left_height = height(node.left)
    right_height = height(node.right)
    if ((left_height - right_height).abs <= 1)
      return true
    end
    return false
  end

  def rebalance
    level_arr = level_order(@root)
    @root = build_tree(level_arr)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# arr = [1, 3, 3, 2, 4, 5, 7, 8]
# tree = Tree.new(arr)

#p tree.find(6)
# tree.insert(6)
# tree.insert(9)
# tree.insert(11)
# tree.insert(12)
# tree.pretty_print
#puts 'inserted 6'
#tree.delete(tree.root, 7)
#puts 'deleted 7'
#p tree.root
#p tree.level_order(tree.root)
#p tree.postorder()
#tree.height(tree.root)
# p tree.balanced?
# tree.rebalance
# tree.pretty_print

# arr = Array.new(15) { rand(1..100) }
# tree = Tree.new(arr)
# tree.insert(124)
# tree.insert(156)
# tree.insert(167)
# tree.insert(114)

# tree.pretty_print
# p tree.balanced?
# p tree.level_order
# p tree.preorder
# p tree.inorder

# tree.rebalance
# p tree.balanced?
# p tree.level_order
# p tree.preorder
# p tree.inorder
# tree.pretty_print







