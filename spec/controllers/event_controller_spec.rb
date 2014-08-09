require 'spec_helper'

describe EventsController do

  describe 'GET#show' do

    it 'should return the event itself' do
      event = FactoryGirl.create(:event)
      get :show, id: event
      assigns(:event).should eql event
    end

    it 'should return all the events comments' do
      event = FactoryGirl.create(:event)
      c = FactoryGirl.create(:comment, event: event)
      get :show, id: event

      assigns(:event).comments.first.should eql c
    end
  end

end
