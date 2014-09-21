require 'spec_helper'

describe CategoriesController do

  describe 'create' do
    it 'should create a category' do
      expect {
        post :create, category: { key: 'queer' }
      }.to change(Category, :count).by(1)
    end

    it 'should return a hash containing the id and the category name when queried via javascript' do
      post :create, category: { key: 'queer' }, format: :json
      body = JSON.parse(response.body)
      expect(body['key']).to eql 'queer'
    end
  end

end