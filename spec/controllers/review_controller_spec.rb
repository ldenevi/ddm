require 'spec_helper'

describe ReviewController do

  describe "GET 'show_task'" do
    it "returns http success" do
      get 'show_task'
      response.should be_success
    end
  end

end
