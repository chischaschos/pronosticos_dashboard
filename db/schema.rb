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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "games", force: true do |t|
    t.integer "sale_id"
    t.string  "name"
    t.integer "units"
    t.float   "total"
  end

  create_table "sales", force: true do |t|
    t.string  "agency"
    t.date    "date"
    t.float   "to_pay_subtotal"
    t.integer "payments_number"
    t.float   "payments_amount"
    t.integer "cancelled_number"
    t.float   "cancelled_amount"
    t.float   "commission"
    t.float   "to_pay_total"
  end

  add_index "sales", ["agency", "date"], name: "index_sales_on_agency_and_date", unique: true, using: :btree

end
