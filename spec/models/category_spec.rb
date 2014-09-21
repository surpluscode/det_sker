require 'spec_helper'

describe Category do
  it 'should create a category with a key and a description' do
    c = Category.new(key: :party, description: 'Fun fun fun!')
    c.save.should be_true
    c.key.should eql :party
  end

  it 'should reject duplicate categories' do
    Category.create(key: :queer)
    c2 = Category.new(key: :queer)
    expect(c2.save).to be_false
    c3 = Category.new(key: :Queer)
    expect(c3.save).to be_false
  end

end
