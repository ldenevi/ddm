class AddNextDeployOnToOrganizationTemplate < ActiveRecord::Migration
  def change
    add_column :organization_templates, :next_deploy_on, :date
  end
end
