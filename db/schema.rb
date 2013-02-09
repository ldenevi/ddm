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

ActiveRecord::Schema.define(:version => 20130207201638) do

  create_table "agencies", :force => true do |t|
    t.string   "name"
    t.string   "acronym"
    t.string   "website"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "agencies", ["acronym"], :name => "index_agencies_on_acronym"
  add_index "agencies", ["name"], :name => "index_agencies_on_name"

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "author_id"
    t.integer  "attachments_count"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "comments", ["author_id"], :name => "index_comments_on_author_id"
  add_index "comments", ["body"], :name => "index_comments_on_body"

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "display_name"
    t.integer  "region_id"
    t.integer  "parent_id"
    t.integer  "root_parent_id"
    t.boolean  "is_leaf",        :default => false
    t.boolean  "is_branch",      :default => false
    t.integer  "owner_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "organizations", ["display_name"], :name => "index_organizations_on_display_name"
  add_index "organizations", ["is_branch"], :name => "index_organizations_on_is_branch"
  add_index "organizations", ["is_leaf"], :name => "index_organizations_on_is_leaf"
  add_index "organizations", ["name"], :name => "index_organizations_on_name"
  add_index "organizations", ["parent_id"], :name => "index_organizations_on_parent_id"
  add_index "organizations", ["region_id"], :name => "index_organizations_on_region_id"
  add_index "organizations", ["root_parent_id"], :name => "index_organizations_on_root_parent_id"

  create_table "purchased_templates", :force => true do |t|
    t.integer  "agency_id"
    t.string   "agency_display_name"
    t.string   "full_name"
    t.string   "display_name"
    t.string   "frequency"
    t.text     "description"
    t.text     "objectives"
    t.string   "regulatory_review_name"
    t.integer  "organization_id"
    t.integer  "revision"
    t.boolean  "is_latest_revision"
    t.integer  "purchased_by_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "purchased_templates", ["display_name"], :name => "index_purchased_templates_on_display_name"
  add_index "purchased_templates", ["full_name"], :name => "index_purchased_templates_on_full_name"
  add_index "purchased_templates", ["organization_id"], :name => "index_purchased_templates_on_organization_id"
  add_index "purchased_templates", ["purchased_by_id"], :name => "index_purchased_templates_on_purchased_by_id"

  create_table "reviews", :force => true do |t|
    t.string   "name"
    t.datetime "assigned_at"
    t.integer  "owner_id"
    t.string   "frequency"
    t.string   "status"
    t.datetime "due_at"
    t.datetime "actual_completion_at"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "reviews", ["assigned_at"], :name => "index_reviews_on_assigned_at"
  add_index "reviews", ["name"], :name => "index_reviews_on_name"
  add_index "reviews", ["owner_id"], :name => "index_reviews_on_owner_id"

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.string   "instructions"
    t.integer  "review_id"
    t.integer  "sequence"
    t.string   "status"
    t.datetime "assigned_at"
    t.datetime "expected_completion_at"
    t.datetime "actual_completion_at"
    t.float    "completion_percentage"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "tasks", ["review_id"], :name => "index_tasks_on_review_id"
  add_index "tasks", ["status"], :name => "index_tasks_on_status"

  create_table "templates", :force => true do |t|
    t.integer  "agency_id"
    t.string   "agency_display_name"
    t.string   "display_name"
    t.string   "full_name"
    t.string   "frequency"
    t.text     "description"
    t.text     "objectives"
    t.string   "regulatory_review_name"
    t.integer  "author_id"
    t.text     "tasks"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "templates", ["agency_display_name"], :name => "index_templates_on_agency_display_name"
  add_index "templates", ["agency_id"], :name => "index_templates_on_agency_id"
  add_index "templates", ["author_id"], :name => "index_templates_on_author_id"
  add_index "templates", ["display_name"], :name => "index_templates_on_display_name"
  add_index "templates", ["full_name"], :name => "index_templates_on_full_name"

  create_table "users", :force => true do |t|
    t.string   "language"
    t.string   "phone"
    t.integer  "organization_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "display_name"
    t.integer  "profile_image_id"
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
