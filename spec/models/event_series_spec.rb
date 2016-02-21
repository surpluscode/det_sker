require 'spec_helper'

describe EventSeries do
  shared_examples 'series' do
    describe 'creating' do
      it { should be_valid }
      it 'should have child events' do
        expect(subject.events.size).to be > 0
      end
      it 'should have child events with the same details' do
        expect(subject.events.first.short_description).to eql subject.description
      end
    end
    describe 'updating' do
      it 'does not create new events' do
        expect{
          subject.update(description: 'A new description')
        }.not_to change{subject.events.count}
      end
      it 'should update the child events' do
        subject.update(description: 'A new description')
        expect(subject.events.first.short_description).to eql 'A new description'
      end
    end
  end

    describe 'weekly series' do
      subject { FactoryGirl.create(:weekly_series) }
      it_behaves_like 'series'
      it 'should create events with a week between them' do
        first_time = subject.events.first.start_time
        second_time = subject.events.second.start_time
        expect(first_time + 1.week).to eql second_time
      end
    end

    describe 'updating a first in month series' do
      subject{ FactoryGirl.create(:first_in_month) }
      it_behaves_like 'series'
    end
    describe 'updating a second in month series' do
      subject{ FactoryGirl.create(:second_in_month) }
      it_behaves_like 'series'
    end
  describe 'updating a third in month series' do
    subject{ FactoryGirl.create(:third_in_month) }
    it_behaves_like 'series'
  end
  describe 'updating a last in month series' do
    subject{ FactoryGirl.create(:last_in_month) }
    it_behaves_like 'series'
  end
end