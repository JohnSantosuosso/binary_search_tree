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
end
