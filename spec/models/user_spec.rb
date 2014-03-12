require 'spec_helper'

describe User do
  let(:trial) { User.new_trial }

  context "in general" do
    it "should be able to create trial users" do
      User.should respond_to(:new_trial)
    end
  end

  context "as trial" do
    it "should have the date the trial was created" do
      trial.should respond_to(:trial_created_at)
      trial.trial_created_at.should_not be_nil
    end
  end
end
