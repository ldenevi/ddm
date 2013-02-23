require 'spec_helper'

describe HelpController do

  describe "GET 'initial_usage'" do
    it "returns http success" do
      get 'initial_usage'
      response.should be_success
    end
  end

end
