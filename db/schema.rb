# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130828200307) do

  create_table "agencies", :force => true do |t|
    t.string   "name"
    t.string   "acronym"
    t.string   "website"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "agencies", ["acronym"], :name => "index_agencies_on_acronym"
  add_index "agencies", ["name"], :name => "index_agencies_on_name"

  create_table "binary_files", :force => true do |t|
    t.string   "filename",        :null => false
    t.text     "mime_types",      :null => false
    t.integer  "attachable_id",   :null => false
    t.string   "attachable_type", :null => false
    t.string   "type"
    t.string   "storage_path",    :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "binary_files", ["attachable_id"], :name => "index_binary_files_on_attachable_id"
  add_index "binary_files", ["attachable_type"], :name => "index_binary_files_on_attachable_type"
  add_index "binary_files", ["filename"], :name => "index_binary_files_on_filename"
  add_index "binary_files", ["mime_types"], :name => "index_binary_files_on_mime_types"
  add_index "binary_files", ["type"], :name => "index_binary_files_on_type"

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "attachments_count"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "author_id"
  end

  add_index "comments", ["author_id"], :name => "index_comments_on_author_id"
  add_index "comments", ["body"], :name => "index_comments_on_body"
  add_index "comments", ["title"], :name => "index_comments_on_title"

  create_table "eicc_declaration_questions", :force => true do |t|
    t.integer  "declaration_id"
    t.integer  "sequence"
    t.text     "question"
    t.string   "tantalum"
    t.text     "tantalum_comment"
    t.string   "tungsten"
    t.text     "tungsten_comment"
    t.string   "tin"
    t.text     "tin_comment"
    t.string   "gold"
    t.text     "gold_comment"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "eicc_declarations", :force => true do |t|
    t.integer  "client_id"
    t.integer  "task_id"
    t.datetime "gsp_template_input_at"
    t.string   "validation_status"
    t.string   "language"
    t.datetime "completion_at"
    t.text     "invalid_reasons"
    t.string   "company_name"
    t.text     "declaration_scope"
    t.text     "description_of_scope"
    t.string   "company_unique_identifier"
    t.string   "address"
    t.string   "authorized_company_representative_name"
    t.string   "representative_title"
    t.string   "representative_email"
    t.string   "representative_phone"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "gsp_templates", :force => true do |t|
    t.float    "price"
    t.integer  "agency_id"
    t.string   "agency_display_name"
    t.text     "description"
    t.string   "display_name"
    t.string   "frequency"
    t.string   "full_name"
    t.text     "objectives"
    t.string   "regulatory_review_name"
    t.text     "tasks"
    t.integer  "author_id"
    t.text     "reasons_for_update"
    t.integer  "parent_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "gsp_templates", ["agency_display_name"], :name => "index_gsp_templates_on_agency_display_name"
  add_index "gsp_templates", ["agency_id"], :name => "index_gsp_templates_on_agency_id"
  add_index "gsp_templates", ["author_id"], :name => "index_gsp_templates_on_author_id"
  add_index "gsp_templates", ["display_name"], :name => "index_gsp_templates_on_display_name"
  add_index "gsp_templates", ["full_name"], :name => "index_gsp_templates_on_full_name"

  create_table "organization_templates", :force => true do |t|
    t.integer  "agency_id"
    t.string   "agency_display_name"
    t.text     "description"
    t.string   "display_name"
    t.string   "frequency"
    t.string   "full_name"
    t.text     "objectives"
    t.integer  "organization_id",                           :null => false
    t.string   "regulatory_review_name"
    t.integer  "gsp_template_id"
    t.integer  "revision"
    t.boolean  "is_latest_revision"
    t.text     "tasks"
    t.boolean  "is_archived"
    t.integer  "approved_by_id"
    t.datetime "approved_at"
    t.integer  "modified_by_id"
    t.integer  "purchased_by_id"
    t.integer  "shared_by_id"
    t.datetime "shared_at"
    t.integer  "parent_id"
    t.integer  "root_parent_id"
    t.boolean  "is_branch",              :default => false
    t.boolean  "is_leaf",                :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.text     "schedule"
    t.date     "next_deploy_on"
  end

  add_index "organization_templates", ["approved_by_id"], :name => "index_organization_templates_on_approved_by_id"
  add_index "organization_templates", ["display_name"], :name => "index_organization_templates_on_display_name"
  add_index "organization_templates", ["full_name"], :name => "index_organization_templates_on_full_name"
  add_index "organization_templates", ["organization_id"], :name => "index_organization_templates_on_organization_id"
  add_index "organization_templates", ["purchased_by_id"], :name => "index_organization_templates_on_purchased_by_id"

  create_table "organizations", :force => true do |t|
    t.string   "full_name"
    t.string   "display_name"
    t.integer  "governing_law_id"
    t.integer  "owner_id"
    t.integer  "parent_id"
    t.integer  "root_parent_id"
    t.boolean  "is_branch",        :default => false
    t.boolean  "is_leaf",          :default => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "organizations", ["display_name"], :name => "index_organizations_on_display_name"
  add_index "organizations", ["full_name"], :name => "index_organizations_on_full_name"
  add_index "organizations", ["governing_law_id"], :name => "index_organizations_on_governing_law_id"
  add_index "organizations", ["is_branch"], :name => "index_organizations_on_is_branch"
  add_index "organizations", ["is_leaf"], :name => "index_organizations_on_is_leaf"
  add_index "organizations", ["parent_id"], :name => "index_organizations_on_parent_id"
  add_index "organizations", ["root_parent_id"], :name => "index_organizations_on_root_parent_id"

  create_table "reviews", :force => true do |t|
    t.integer  "responsible_party_id"
    t.string   "frequency"
    t.string   "name"
    t.integer  "organization_id"
    t.integer  "organization_template_id"
    t.string   "status"
    t.datetime "actual_completion_at"
    t.datetime "actual_start_at"
    t.datetime "targeted_completion_at"
    t.datetime "targeted_start_at"
    t.datetime "assigned_at"
    t.datetime "deployed_at"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.text     "schedule"
  end

  add_index "reviews", ["assigned_at"], :name => "index_reviews_on_assigned_at"
  add_index "reviews", ["name"], :name => "index_reviews_on_name"
  add_index "reviews", ["organization_template_id"], :name => "index_reviews_on_organization_template_id"
  add_index "reviews", ["responsible_party_id"], :name => "index_reviews_on_responsible_party_id"

  create_table "tasks", :force => true do |t|
    t.integer  "reviewer_id",                                               :null => false
    t.float    "completion_percentage"
    t.text     "instructions",                                              :null => false
    t.string   "name"
    t.integer  "review_id",                                                 :null => false
    t.integer  "sequence",               :default => 1,                     :null => false
    t.string   "status",                 :default => "Inactive",            :null => false
    t.datetime "actual_completion_at"
    t.datetime "assigned_at"
    t.datetime "expected_completion_at", :default => '2013-06-13 21:24:55', :null => false
    t.datetime "start_at"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.text     "schedule"
  end

  add_index "tasks", ["review_id"], :name => "index_tasks_on_review_id"
  add_index "tasks", ["reviewer_id"], :name => "index_tasks_on_reviewer_id"
  add_index "tasks", ["status"], :name => "index_tasks_on_status"

  create_table "users", :force => true do |t|
    t.integer  "organization_id",                        :null => false
    t.string   "display_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.integer  "profile_image_id"
    t.string   "language"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
