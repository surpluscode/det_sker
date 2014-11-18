require 'spec_helper'

describe Category do
  it 'should create a category with a key and a description' do
    c = FactoryGirl.build(:category, key: Time.now.to_s)
    expect(c).to be_valid
  end

  it 'should reject duplicate categories' do
    key = Time.now.to_s
    FactoryGirl.create(:category, key: key)
    c2 = FactoryGirl.build(:category, key: key)
    expect(c2).to_not be_valid
  end

end
