class CreateCfsiCmrtValidations < ActiveRecord::Migration
  def change
    create_table :cfsi_cmrt_validations do |t|
      t.references :cmrt
      t.datetime :email_sent_at
      t.text :issues
      t.integer :sent_emails_count
      t.string :status
      t.integer :validation_attempt
      t.references :validations_batch
      t.references :vendor

      t.timestamps
    end
    add_index :cfsi_cmrt_validations, :cmrt_id
    add_index :cfsi_cmrt_validations, :validations_batch_id
  end
end
