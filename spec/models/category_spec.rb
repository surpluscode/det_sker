require 'spec_helper'

describe Category do
  it 'should create a category with a key and a description' do
    c = Category.new(key: :party, description: 'Fun fun fun!')
    c.save.should be_true
    c.key.should eql :party
  end

end
