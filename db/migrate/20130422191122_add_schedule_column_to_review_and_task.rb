class AddScheduleColumnToReviewAndTask < ActiveRecord::Migration
  def change
    add_column :reviews, :schedule, :string
    add_column :tasks, :schedule, :string
  end
end
