# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_28_231953) do
  create_table "contracts", force: :cascade do |t|
    t.integer "job_id", null: false
    t.integer "client_id", null: false
    t.integer "freelancer_id", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal "amount"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_contracts_on_client_id"
    t.index ["freelancer_id"], name: "index_contracts_on_freelancer_id"
    t.index ["job_id"], name: "index_contracts_on_job_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "budget"
    t.datetime "deadline"
    t.string "status"
    t.integer "client_id", null: false
    t.text "skills_required"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_jobs_on_client_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "contract_id", null: false
    t.decimal "amount"
    t.string "status"
    t.string "payment_method"
    t.string "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_payments_on_contract_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.text "bio"
    t.decimal "hourly_rate"
    t.text "skills"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.integer "job_id", null: false
    t.integer "freelancer_id", null: false
    t.text "cover_letter"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["freelancer_id"], name: "index_proposals_on_freelancer_id"
    t.index ["job_id"], name: "index_proposals_on_job_id"
  end

  create_table "time_entries", force: :cascade do |t|
    t.integer "contract_id", null: false
    t.integer "freelancer_id", null: false
    t.decimal "hours"
    t.text "description"
    t.date "date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_time_entries_on_contract_id"
    t.index ["freelancer_id"], name: "index_time_entries_on_freelancer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contracts", "clients"
  add_foreign_key "contracts", "freelancers"
  add_foreign_key "contracts", "jobs"
  add_foreign_key "jobs", "clients"
  add_foreign_key "payments", "contracts"
  add_foreign_key "profiles", "users"
  add_foreign_key "proposals", "freelancers"
  add_foreign_key "proposals", "jobs"
  add_foreign_key "time_entries", "contracts"
  add_foreign_key "time_entries", "freelancers"
end
