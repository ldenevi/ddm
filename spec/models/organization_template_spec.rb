require 'spec_helper'

describe OrganizaitonTemplate do
  describe 'data validations' do
    it 'should prevent hazardous field values' do
      pending 'must have purchased data, agency fields, and organization'
    end
  end
  
  describe 'behavior' do
    it 'should create revision upon edit to certain fields' do
      pending "changes to objective and tasks spawns a new record with incremented revision number"
    end
    
    it "should be sharable to organizations within the user's permissible locations" do
      pending "new copies based on self's revision are created for seleected organizations"
    end
    
    it "should spawn review with objectized tasks" do
      pending "create review and tasks objects"
    end
    
    it "should send signal to itself and its *latest* children to deploy reviews" do
      pending "For now, user must manually deploy"
    end
  end
end
