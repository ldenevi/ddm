class AddScheduleColumnToOrganizationTemplateAndReviewAndTask < ActiveRecord::Migration
  def change
    add_column :reviews, :schedule, :text
    add_column :tasks, :schedule, :text
    add_column :organization_templates, :schedule, :text
  end
end
