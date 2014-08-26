require 'spec_helper'

describe CategoriesController do

  before :each do
    FactoryGirl.create(:category)
  end

  describe 'GET#data' do
    it 'should retrieve a list of categories' do
      xhr(:get, 'data')
      body = JSON.parse(response.body)
      body.should include 'party'
    end
  end
end