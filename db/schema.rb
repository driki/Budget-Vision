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

ActiveRecord::Schema.define(:version => 20120108180602) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.text     "goal"
    t.text     "challenge"
    t.text     "description"
    t.float    "expense_budget"
    t.float    "revenue_budget"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
  end

  create_table "forecasts", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goals", :force => true do |t|
    t.text     "name"
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
    t.boolean  "is_expense"
    t.string   "type"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organization_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "state"
    t.boolean  "type"
    t.boolean  "is_verified"
    t.integer  "population"
    t.float    "pop_sq_mi"
    t.float    "total_sq_mi"
    t.integer  "housing_units"
    t.float    "housing_percent_vacant"
    t.float    "diversity"
    t.string   "fips"
    t.string   "gnis"
    t.integer  "opener_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "summary"
    t.float    "expense_budget"
    t.float    "revenue_budget"
    t.string   "type"
    t.integer  "year"
    t.float    "average_tax_bill"
    t.boolean  "enable_comments"
    t.boolean  "enable_tips"
    t.boolean  "is_demo"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

end
