require_relative 'bst'

RSpec.describe Tree do
  let(:arr) { [2,1,3,5,4] }
  let(:tree) { Tree.new(arr) }
  
  it 'instantiates an object' do
    expect(tree.root).to be_a(Node)
    expect(tree.root.left.data).to eql 2
  end

  it 'inserts a value' do
    tree.insert(6)
    expect(tree.root.right.right.data).to eql 6
    expect(tree.root.right.data).to eql 5
  end

  it 'finds a value' do
    result = tree.find(5)
    expect(result.data).to eql 5
  end

  it 'deletes a value' do
    require 'pry'; binding.pry 
  end
end
