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

ActiveRecord::Schema.define(version: 20170529153005) do

  create_table "active_admin_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "namespace"
    t.text     "body",          limit: 65535
    t.string   "resource_id",                 null: false
    t.string   "resource_type",               null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "writer_id",                null: false
    t.integer  "owner_id",                 null: false
    t.string   "view_scope",               null: false
    t.float    "rate",       limit: 24
    t.text     "content",    limit: 65535
    t.integer  "trip_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "state"
    t.index ["owner_id"], name: "index_reviews_on_owner_id", using: :btree
    t.index ["trip_id"], name: "index_reviews_on_trip_id", using: :btree
    t.index ["writer_id"], name: "index_reviews_on_writer_id", using: :btree
  end

  create_table "trip_members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "trip_id",    null: false
    t.integer  "member_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_trip_members_on_member_id", using: :btree
    t.index ["trip_id", "member_id"], name: "index_trip_members_on_trip_id_and_member_id", unique: true, using: :btree
    t.index ["trip_id"], name: "index_trip_members_on_trip_id", using: :btree
  end

  create_table "trips", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "owner_id",                         null: false
    t.string   "address",                          null: false
    t.date     "check_in",                         null: false
    t.date     "check_out",                        null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.float    "latitude",           limit: 24
    t.float    "longitude",          limit: 24
    t.string   "city"
    t.string   "country"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "content",            limit: 65535
    t.index ["owner_id"], name: "index_trips_on_owner_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                                default: "",   null: false
    t.string   "encrypted_password",                   default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "authentication_token",   limit: 30
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.date     "date_of_birth"
    t.string   "gender"
    t.string   "mobile_number"
    t.string   "locale",                               default: "ko", null: false
    t.string   "country",                              default: "kr", null: false
    t.text     "introduction",           limit: 65535
    t.string   "school"
    t.string   "job"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "reviews", "users", column: "owner_id"
  add_foreign_key "reviews", "users", column: "writer_id"
  add_foreign_key "trip_members", "trips"
  add_foreign_key "trip_members", "users", column: "member_id"
  add_foreign_key "trips", "users", column: "owner_id"
end
