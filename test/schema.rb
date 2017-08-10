ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "login"
    t.string   "website"
    t.integer  "blob_id"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.integer  "application_id"
  end

  add_index "users", ["account_id"], name: "users_account_id_fk", using: :btree
  add_index "users", ["application_id"], name: "index_users_on_application_id", using: :btree
  add_index "users", ["application_id", "email"], name: "index_users_on_application_id_and_email", using: :btree
  add_index "users", ["blob_id"], name: "users_blob_id_fk", using: :btree
  add_index "users", ["full_name"], name: "index_users_on_full_name", using: :btree
  add_index "users", ["login", "application_id"], name: "index_users_on_login_and_application_id", using: :btree

  create_table "applications", :force => true do |t|
     t.string   "title"
     t.text     "description"
     t.datetime "created_at"
     t.datetime "updated_at"
     t.integer  "account_id"
  end

  add_index "applications", ["account_id"], name: "applications_account_id_fk", using: :btree

end
