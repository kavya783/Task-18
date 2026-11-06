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

ActiveRecord::Schema[8.1].define(version: 2026_11_06_055651) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.string "appointment_type"
    t.datetime "created_at", null: false
    t.integer "doctor_id", null: false
    t.text "doctor_notes"
    t.integer "hospital_id", null: false
    t.integer "patient_id", null: false
    t.text "reason"
    t.datetime "scheduled_at"
    t.string "status"
    t.integer "token_number"
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["hospital_id"], name: "index_appointments_on_hospital_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "city"
    t.datetime "created_at", null: false
    t.string "email"
    t.integer "hospital_id", null: false
    t.string "name"
    t.string "password_digest"
    t.string "phone"
    t.string "qualification"
    t.string "specialization"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["hospital_id"], name: "index_doctors_on_hospital_id"
    t.index ["user_id"], name: "index_doctors_on_user_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "address"
    t.string "api_token"
    t.string "city"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "phone"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["api_token"], name: "index_hospitals_on_api_token", unique: true
    t.index ["user_id"], name: "index_hospitals_on_user_id"
  end

  create_table "patients", force: :cascade do |t|
    t.integer "age"
    t.datetime "created_at", null: false
    t.string "disease"
    t.integer "doctor_id"
    t.string "email"
    t.integer "hospital_id"
    t.string "name"
    t.string "password_digest"
    t.string "phone"
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_patients_on_doctor_id"
    t.index ["email"], name: "index_patients_on_email", unique: true
    t.index ["hospital_id"], name: "index_patients_on_hospital_id"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.integer "appointment_id"
    t.datetime "created_at", null: false
    t.integer "doctor_id", null: false
    t.integer "patient_id", null: false
    t.text "prescription"
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_prescriptions_on_doctor_id"
    t.index ["patient_id"], name: "index_prescriptions_on_patient_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "address"
    t.text "bio"
    t.datetime "created_at", null: false
    t.integer "hospital_id", null: false
    t.string "phone"
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_profiles_on_hospital_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "api_token"
    t.string "city"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "hospital_name"
    t.string "phone"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role"
    t.datetime "updated_at", null: false
    t.index ["api_token"], name: "index_users_on_api_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "welcomes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "hospitals"
  add_foreign_key "appointments", "patients"
  add_foreign_key "doctors", "hospitals"
  add_foreign_key "doctors", "users"
  add_foreign_key "hospitals", "users"
  add_foreign_key "patients", "doctors"
  add_foreign_key "patients", "hospitals"
  add_foreign_key "prescriptions", "doctors"
  add_foreign_key "prescriptions", "patients"
  add_foreign_key "profiles", "hospitals"
end
