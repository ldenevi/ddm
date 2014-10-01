require 'spec_helper'

describe Admin::ClientsController do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:organization_attrs) { {:name => "Test ACME Industries"} } 
  let(:user_attrs) { {:email => "test_client_user@client.co", :password => "password", :first_name => "Test", :last_name => "Client"} }
  let(:user) { FactoryGirl.create(:user) }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "POST 'add_organization'" do
    it "returns http success" do
      expect { post 'add_organization', :organization => organization_attrs }.to change { Organization.count }.by(1)
      response.should be_success
    end
  end

  describe "GET 'view'" do
    it "returns http success" do
      get 'view', :id => organization.id
      response.should be_success
    end
  end

  describe "POST 'add_user'" do
    it "returns http success" do
      expect { post 'add_user', :organization_id => organization.id, :user => user_attrs }.to change { User.count }.by(1)
      response.should be_success
    end
    
    it "JSON returns success and user attributes" do
      expect { post 'add_user', :format => :json, :organization_id => organization.id, :user => user_attrs }.to change { User.count }.by(1)
      expect(response.body).to match '"success":true'
    end
  end

  describe "DELETE 'delete_user'" do
    it "returns http success" do
      expect(user.id).not_to be_nil
      user.organization = organization
      user.save!
      expect { delete 'delete_user', :organization_id => organization.id, :user_id => user.id }.to change { User.count }.by(-1)
      response.should be_success
    end
    
    it "JSON returns success" do
      expect(user.id).not_to be_nil
      user.organization = organization
      user.save!
      expect { delete 'delete_user', :format => :json, :organization_id => organization.id, :user_id => user.id }.to change { User.count }.by(-1)
      expect(response.body).to match '"success":true'
    end
  end

  describe "DELETE 'delete_organization'" do
    it "returns http success" do
      expect(organization.id).not_to be_nil
      expect { 
        expect(user.id).not_to be_nil
        user.organization = organization
        user.save!
      }.to change { User.count }.by(1)
      expect {
        expect { delete 'delete_organization', :id => organization.id }.to change { Organization.count }.by(-1)
      }.to change { User.count }.by(-1)
      response.should be_success
    end
    it "JSON returns success is true" do
      expect(organization.id).not_to be_nil
      expect { 
        expect(user.id).not_to be_nil
        user.organization = organization
        user.save!
      }.to change { User.count }.by(1)
      expect {
        expect { delete 'delete_organization', :format => :json, :id => organization.id }.to change { Organization.count }.by(-1)
      }.to change { User.count }.by(-1)
      response.should be_success
      expect(response.body).to match '"success":true'
    end
  end
  
  let(:invalid_orgnaization_attrs) { {:name => nil} }
  let(:invalid_user_attrs) { {} }
  
  context "during invalid" do
    describe "POST 'add_user'" do
      it "fails and redirects to 'view'" do
        expect { post 'add_user', :organization_id => organization.id, :user => invalid_user_attrs }.to change { User.count }.by(0)
        expect(response).to redirect_to :action => 'view', :id => organization.id
        expect(response.inspect).to match "[\"Email can't be blank\", \"Password can't be blank\"]}"
      end
      
      it "JSON fails and returns false" do
        expect { post 'add_user', :format => :json, :organization_id => organization.id, :user => invalid_user_attrs }.to change { User.count }.by(0)
        expect(response.body).to match '"success":false'
      end
    end
    
    describe "DELETE 'delete_user'" do
      it "fails and redirects to 'view' with flash error" do
        expect(organization.id).not_to be_nil
        expect(user.id).not_to be_nil
        expect(user.organization.id).not_to eq organization.id
        expect { delete 'delete_user', :organization_id => organization.id, :user_id => user.id }.to change { User.count }.by(0)
        expect(response).to be_redirect
        expect(response.inspect).to match "Couldn't find User with id=#{user.id}"
      end
      it "JSON fails and success is false with flash error" do
        expect(organization.id).not_to be_nil
        expect(user.id).not_to be_nil
        expect(user.organization.id).not_to eq organization.id
        expect { delete 'delete_user', :format => :json, :organization_id => organization.id, :user_id => user.id }.to change { User.count }.by(0)
        expect(response.body).to match '"success":false'
        expect(response.body).to match "Couldn't find User with id=#{user.id}"
      end
    end
    
    describe "DELETE 'delete_organization'" do
      it "fails and directs to 'view' with flash error" do
        expect { delete 'delete_organization', :id => -1 }.to change { Organization.count }.by(0)
        expect(response).to be_redirect
        expect(response.inspect).to match "Couldn't find Organization with id=-1"
      end
      it "JSON fails and success if false with flash error" do
        expect { delete 'delete_organization', :format => :json, :id => -1 }.to change { Organization.count }.by(0)
        expect(response.body).to match '"success":false'
        expect(response.body).to match "Couldn't find Organization with id=-1"
      end
    end
  end

end
