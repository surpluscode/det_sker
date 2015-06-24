require 'spec_helper'

describe EventsController do

  describe 'GET#show' do

    it 'should return the event itself' do
      event = FactoryGirl.create(:event)
      get :show, id: event
      expect(assigns(:event)).to eql event
    end

    it 'should return all the events comments' do
      event = FactoryGirl.create(:event)
      c = FactoryGirl.create(:comment, event: event)
      get :show, id: event

      expect(assigns(:event).comments.first).to eql c
    end
  end

end
