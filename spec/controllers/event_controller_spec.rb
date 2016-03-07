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

  describe 'GET#open_graph' do
    render_views
    let(:event) { FactoryGirl.create(:event) }
    before do
      get :open_graph, id: event
    end
    it 'assigns an event presenter' do
      expect(assigns(:event_presenter).object).to eql event
    end

    it 'includes the fb tags' do
      expect(response.body).to include 'og:url'
      expect(response.body).to include 'og:title'
      expect(response.body).to include 'og:description'
    end
  end

end
