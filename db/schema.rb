# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100423180319) do

  create_table "slugs", :force => true do |t|
    t.string   "scope"
    t.string   "slug"
    t.integer  "record_id"
    t.datetime "created_at"
  end

  add_index "slugs", ["scope", "record_id", "created_at"], :name => "index_slugs_on_scope_and_record_id_and_created_at"
  add_index "slugs", ["scope", "record_id"], :name => "index_slugs_on_scope_and_record_id"
  add_index "slugs", ["scope", "slug", "created_at"], :name => "index_slugs_on_scope_and_slug_and_created_at"
  add_index "slugs", ["scope", "slug"], :name => "index_slugs_on_scope_and_slug"

end