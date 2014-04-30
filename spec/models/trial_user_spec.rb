require 'spec_helper'

describe Trial::TrialUser do
  let(:standard_user) { User.new }
  let(:trial_user) { Trial::TrialUser.new }

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

  let(:trial_user_with_forbidden_domain) { Trial::TrialUser.new :email => "some.person@hotmail.com", :password => "password1" }

  context "during invalid domain registration" do
    it "should contain list of forbidden domains" do
      expect(Trial::TrialUser).to respond_to :forbidden_domains
      %w(gmail yahoo hotmail outlook hushmail aol gmx inbox).each do |domain|
        expect(Trial::TrialUser.forbidden_domains).to include domain
      end
    end

    it "should prevent registration from" do
      expect(trial_user_with_forbidden_domain).not_to be_valid
      expect(trial_user_with_forbidden_domain.errors.messages).to include({:email => [" from 'hotmail.com' is invalid. Please use your company's email address."]})
    end
  end

  it "should be able to create record with valid e-mail" do
    expect { Trial::TrialUser.create :email => "trial.user@some.domain.co.uk", :password => "password1" }.to change{Trial::TrialUser.count}.by(1)
  end

  let(:already_registered_domain_email) {
    Trial::TrialUser.create :email => "first.user@already.registered.com", :password => "password1"
    Trial::TrialUser.new :email => "second.user@already.registered.com", :password => "password1"
  }
  it "should prevent registering an email from a previously registered domain" do
    already_registered_domain_email.save
    expect(already_registered_domain_email).to be_invalid
    expect(already_registered_domain_email.errors.messages).to include({:email => ["domain 'already.registered.com' has been previously registered"]})
  end
end

require 'rake'

describe "gsp:app:trial:lock_expired_users" do
  let(:expired_trial_user) {
    etu = Trial::TrialUser.create :email => "expired@user.com", :password => "password1"
    etu.update_attribute(:created_at, 15.days.ago)
    etu
  }

  before do
    load File.expand_path("../../../lib/tasks/gsp.rake", __FILE__)
    Rake::Task.define_task(:environment)
  end


  it "should lock expired trial users" do
    expect(expired_trial_user.created_at).to be < Time.now - Trial::TrialUser.trial_period
    Rake::Task["gsp:app:trial:lock_expired_users"].invoke
    expect(expired_trial_user.reload.access_locked?).to be_true
  end
end
