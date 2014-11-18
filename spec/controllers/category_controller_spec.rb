require 'spec_helper'

describe CategoriesController do

  describe 'create' do
    it 'should create a category' do
      expect {
        post :create, category: { key: Time.now.to_i }
      }.to change(Category, :count).by(1)
    end

    it 'should return a hash containing the id and the category name when queried via javascript' do
      word = Time.now.to_i
      post :create, category: { key: word}, format: :json
      body = JSON.parse(response.body)
      expect(body['key']).to eql word
    end
  end

end