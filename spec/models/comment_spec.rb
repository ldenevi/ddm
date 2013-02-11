require 'spec_helper'

describe Comment do
  describe 'field validations' do
    it 'should prevent hazardous field values' do
      pending 'display fields'
    end
  end
  
  describe 'file attachments' do
    it 'should limit acceptable file formats' do
      pending '.pdf, Office files, images (.png, .jpg)'
    end
    
    it 'should attach white-listed files' do
      pending 'attach acceptable file'
    end
    
    it 'should cache attachments count' do
      pending 'cache attachments count'
    end
  end
end
