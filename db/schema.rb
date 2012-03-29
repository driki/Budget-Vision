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

ActiveRecord::Schema.define(:version => 20120329054536) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "goal"
    t.text     "challenge"
    t.text     "description"
    t.string   "tags"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.integer  "people"
  end

  add_index "categories", ["ancestry"], :name => "index_categories_on_ancestry"
  add_index "categories", ["project_id"], :name => "index_categories_on_project_id_and_is_expense"

  create_table "forecasts", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goals", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "summary"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "number"
    t.string   "name"
    t.text     "description"
    t.float    "total"
    t.string   "tags"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_expense",  :default => true
  end

  add_index "items", ["category_id"], :name => "index_items_on_category_id"

  create_table "organization_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "state"
    t.boolean  "is_verified"
    t.integer  "population"
    t.float    "pop_sq_mi"
    t.float    "total_sq_mi"
    t.integer  "housing_units"
    t.float    "housing_percent_vacant"
    t.float    "diversity"
    t.string   "fips"
    t.string   "gnis"
    t.integer  "owner_id"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "is_demo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_count"
    t.string   "type"
    t.string   "slug"
    t.string   "website"
    t.string   "website_vendor"
  end

  add_index "organizations", ["latitude", "longitude"], :name => "index_organizations_on_latitude_and_longitude"
  add_index "organizations", ["name", "state"], :name => "index_organizations_on_name_and_state"

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "summary"
    t.float    "expense_budget",   :default => 0.0
    t.float    "revenue_budget",   :default => 0.0
    t.string   "type"
    t.integer  "year"
    t.float    "average_tax_bill", :default => 0.0
    t.boolean  "enable_comments",  :default => true
    t.boolean  "enable_tips",      :default => false
    t.boolean  "is_demo",          :default => false
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "status"
    t.boolean  "published",        :default => false
    t.string   "csv"
  end

  create_table "sources", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "email"
    t.string   "name"
    t.string   "nickname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
