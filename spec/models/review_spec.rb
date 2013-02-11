require 'spec_helper'

describe Review do
  describe 'data validations' do
    it 'should prevent hazardous field values' do
      pending 'must have purchased data, owner, and organization'
    end
    
    it 'should have logical dates' do
      pending 'end date cannot be before start date, nor any dates before today (duh)'
      @review = Review.new
    end
  end
  
  describe 'behavior' do
    it 'should upon creation send out notification e-mails to its task executors, and review owner' do
      pending 'eventually to other messaging devices'
    end
  end
end
