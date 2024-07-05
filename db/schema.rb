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

ActiveRecord::Schema[7.0].define(version: 2024_07_04_191812) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.bigint "worker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["worker_id"], name: "index_customers_on_worker_id"
  end

  create_table "filaments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_invitations", force: :cascade do |t|
    t.string "status"
    t.bigint "print_maker_id", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_invitations_on_order_id"
    t.index ["print_maker_id"], name: "index_order_invitations_on_print_maker_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "quantity"
    t.date "deadline"
    t.bigint "filament_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["filament_id"], name: "index_orders_on_filament_id"
  end

  create_table "print_maker_orders", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "print_maker_id", null: false
    t.integer "reserved_quantity"
    t.integer "completed_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_print_maker_orders_on_order_id"
    t.index ["print_maker_id"], name: "index_print_maker_orders_on_print_maker_id"
  end

  create_table "print_makers", force: :cascade do |t|
    t.string "status"
    t.string "rank"
    t.bigint "worker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["worker_id"], name: "index_print_makers_on_worker_id"
  end

  create_table "print_makers_filaments", id: false, force: :cascade do |t|
    t.bigint "print_maker_id", null: false
    t.bigint "filament_id", null: false
    t.index ["filament_id"], name: "index_print_makers_filaments_on_filament_id"
    t.index ["print_maker_id"], name: "index_print_makers_filaments_on_print_maker_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "name"
    t.string "provider"
    t.string "uid"
    t.string "avatar_url"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workers", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workers_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "customers", "workers"
  add_foreign_key "order_invitations", "orders"
  add_foreign_key "order_invitations", "print_makers"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "filaments"
  add_foreign_key "print_maker_orders", "orders"
  add_foreign_key "print_maker_orders", "print_makers"
  add_foreign_key "print_makers", "workers"
  add_foreign_key "print_makers_filaments", "filaments"
  add_foreign_key "print_makers_filaments", "print_makers"
  add_foreign_key "workers", "users"
end
