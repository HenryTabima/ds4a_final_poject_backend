# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_06_220243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "departments", id: false, force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.float "area"
    t.float "perimeter"
    t.float "hectares"
    t.string "region"
    t.geometry "geometry", limit: {:srid=>0, :type=>"geometry"}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_departments_on_code", unique: true
  end

  create_table "metric_types", force: :cascade do |t|
    t.string "name"
    t.string "units"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "metrics", force: :cascade do |t|
    t.bigint "department_id", null: false
    t.bigint "type_id", null: false
    t.float "value"
    t.date "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_metrics_on_department_id"
    t.index ["type_id"], name: "index_metrics_on_type_id"
  end

  add_foreign_key "metrics", "departments", primary_key: "code"
  add_foreign_key "metrics", "metric_types", column: "type_id"
end
