require 'spec_helper'

describe CategoriesController do

  before :each do
    FactoryGirl.create(:category)
  end

  describe 'GET#search' do
    it 'should retrieve a list of search results' do
      xhr(:get, 'search', {q: 'p'})
      body = JSON.parse(response.body)
      body.first.should include "key" => 'party'
    end
  end
end