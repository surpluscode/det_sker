require 'spec_helper'

describe Category do
  it 'should create a category with a key and a description' do
    c = FactoryGirl.build(:category)
    expect(c).to be_valid
  end

  it 'should reject duplicate categories' do
    FactoryGirl.create(:category, key: :queer)
    c2 = FactoryGirl.build(:category, key: :queer)
    expect(c2).to_not be_valid
    c3 = FactoryGirl.build(:category, key: :queer)
    expect(c3).to_not be_valid
  end

end
