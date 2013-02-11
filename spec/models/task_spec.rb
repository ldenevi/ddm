require 'spec_helper'

describe Task do
  describe 'data validations' do
    it 'should prevent hazardous field values' do
      pending 'must have purchased data, executor, and organization'
    end
    
    it 'should have logical dates' do
      pending 'end date cannot be before start date, nor any dates before today (duh)'
    end
  end
  
  describe 'behavior' do
    it 'should send out notification (email/SMS/etc) on status updates' do
      pending 'perhaps also to a subscriber list'
    end
  end
end
