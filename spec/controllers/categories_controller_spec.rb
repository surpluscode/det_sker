require 'spec_helper'

describe CategoriesController do

  describe 'create' do
    it 'should create a category' do
      expect {
        post :create, category: { english: 'party', danish: 'fest'}
      }.to change(Category, :count).by(1)
    end
  end

end