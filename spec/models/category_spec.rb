require 'spec_helper'

describe Category do
  it 'has a danish and an english name' do
    category = Category.new(danish: 'fest', english: 'party')
    expect(category).to be_valid
  end
  it 'has a unique danish name' do
    cat1 = Category.create(danish: 'fest', english: 'party')
    cat2 = Category.new(danish: 'fest', english: 'partay')
    expect(cat2).not_to be_valid
  end
  it 'has a unique english name' do
    cat1 = Category.create(danish: 'demo', english: 'demonstration')
    cat2 = Category.new(danish: 'manifestation', english: 'demonstration')
    expect(cat2).not_to be_valid
  end

  it 'has many events'

  it 'returns all the categories of events currently happening'
end
