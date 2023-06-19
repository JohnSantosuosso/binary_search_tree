class Node
  include Comparable
  attr_accessor :right, :left, :data
  def initialize(data, _right = nil, _left = nil)
    @data = data
    @right = nil
    @left = nil
  end
end

class Tree
  attr_accessor :root
  def initialize(arr)
    @root = build_tree(arr.uniq.sort)
  end

  def build_tree(arr)
    return if arr.empty?

    mid = arr.size / 2
    root = Node.new(arr[mid])

    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[mid + 1..-1])

    root
  end

  def insert(value)
    return @root = Node.new(value) if @root.nil?

    node = @root

    loop do
      if value < node.data
        if node.left.nil?
          node.left = Node.new(value)
          return self
        end
      
        node = node.left
      elsif value > node.data
        if node.right.nil?
          node.right = Node.new(value)
          return self
        end

        node = node.right
      else
        break
      end
    end
  end

  def find(value)
    node = @root
    loop do
      return node if node.data == value
      return nil if node.left.nil? && node.right.nil?

      node = value < node.data ? node.left : node.right
    end
  end

  def delete(value)
    node = find(value)
    return nil if node.nil?
    require 'pry'; binding.pry 

    node_parent = node_parent(value)

    #Check to see if the node we're deleting has children
    if node.left.nil? && node.right.nil?
      return @root.data = nil if node_parent.nil?

      node_parent.left == node ? node_parent.left = nil : node_parent.right = nil
      return
    end
    #Check to see if node we're deleting has a right child
    if node.left.nil? && !node.right.nil?
      node_parent.left = (node_parent.left.data == data ? node.right : node.right)
      return
    end

    #Check to see if node we're deleting has a left child
    if node.right.nil? && !node.left.nil?
      node_parent.left = (node_parent.left.data == data ? node.right : node.right)
      return
    end

    #If none of the above and the node has two children
    node_min = node_min_in_r(node)
    delete(node_min.data)
    node.data = node_min.data
  end

  def node_parent(value)
    return nil if @root.data == value

    node = @root
    loop do
      if value < node.data
        return node if node.left.data == value

        node = node.left
      else
        return node if node.right.data == value
      end

      return nil if node.left.nil? && node.right.nil?
    end
  end

  def node_min_in_r(node)
    node = node.right
    until node.left == node.right
      if node.left.nil?
        node = node.right
        next
      end
      node = node.left
    end
    node
  end

  private :node_min_in_r

end
