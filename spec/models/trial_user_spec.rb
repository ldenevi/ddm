require 'spec_helper'

describe Trial::TrialUser do
  let(:standard_user) { User.new }
  let(:trial_user) { Trial::TrialUser.new }
  let(:trial_user_with_forbidden_domain) { Trial::TrialUser.new :email => "some.person@hotmail.com", :password => "password1" }

  it "should not have trial_created_at as nil" do
    expect(trial_user.trial_created_at).not_to be_nil
  end

  it "should not affect User's trial_created_at" do
    expect(standard_user.trial_created_at).to be_nil
  end

  it "should have a 14-day trial period" do
    expect(Trial::TrialUser).to respond_to :trial_period
    expect(Trial::TrialUser.trial_period).to eq 2.weeks
  end

  context "during invalid domain registration" do
    it "should contain list of forbidden domains" do
      expect(Trial::TrialUser).to respond_to :forbidden_domains
      %w(gmail yahoo hotmail outlook hushmail aol gmx inbox).each do |domain|
        expect(Trial::TrialUser.forbidden_domains).to include domain
      end
    end

    it "should prevent registration from" do
      expect(trial_user_with_forbidden_domain).not_to be_valid
      expect(trial_user_with_forbidden_domain.errors.messages).to include({:email => ["is invalid"]})
    end
  end

  it "should be able to create record with valid e-mail" do
    expect { Trial::TrialUser.create :email => "trial.user@some.domain.co.uk", :password => "password1" }.to change{Trial::TrialUser.count}.by(1)
  end
end
