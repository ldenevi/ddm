class AddTrialFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :trial_created_at, :datetime
  end
end
