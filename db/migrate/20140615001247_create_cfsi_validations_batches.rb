class CreateCfsiValidationsBatches < ActiveRecord::Migration
  def change
    create_table :cfsi_validations_batches do |t|
      t.string :status
      t.references :organization
      t.references :user

      t.timestamps
    end
    add_index :cfsi_validations_batches, :organization_id
    add_index :cfsi_validations_batches, :user_id
  end
end
