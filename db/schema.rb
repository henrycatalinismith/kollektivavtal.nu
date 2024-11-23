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

ActiveRecord::Schema[8.0].define(version: 2024_11_23_065335) do
# Could not dump table "active_storage_attachments" because of following StandardError
#   Unknown type 'uuid' for column 'record_id'


  create_table "active_storage_blobs", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
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

# Could not dump table "active_storage_variant_records" because of following StandardError
#   Unknown type 'uuid' for column 'blob_id'


  create_table "blog_posts", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title_en", null: false
    t.text "body_en", null: false
    t.date "published_at"
    t.string "slug"
    t.string "title_sv"
    t.string "body_sv"
    t.index ["published_at"], name: "index_blog_posts_on_published_at"
    t.index ["slug"], name: "index_blog_posts_on_slug", unique: true
  end

  create_table "flipper_features", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "feature_key", null: false
    t.string "key", null: false
    t.text "value"
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "labour_market_agreement_memberships", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "agreement_id"
    t.string "organisation_id"
    t.index ["agreement_id"], name: "index_labour_market_agreement_memberships_on_agreement_id"
    t.index ["organisation_id"], name: "index_labour_market_agreement_memberships_on_organisation_id"
  end

  create_table "labour_market_agreement_versions", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "agreement_id"
    t.integer "signing_year"
    t.integer "expiry_year"
    t.index ["agreement_id", "signing_year"], name: "idx_on_agreement_id_signing_year_666f2c94c5"
    t.index ["agreement_id"], name: "index_labour_market_agreement_versions_on_agreement_id"
  end

  create_table "labour_market_agreements", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_sv", null: false
    t.string "slug"
    t.text "description_en"
    t.string "name_en"
    t.text "description_sv"
    t.index ["name_en"], name: "index_labour_market_agreements_on_name_en"
    t.index ["name_sv"], name: "index_labour_market_agreements_on_name_sv"
    t.index ["slug"], name: "index_labour_market_agreements_on_slug", unique: true
  end

  create_table "labour_market_bookmarks", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url", null: false
  end

  create_table "labour_market_documents", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_en", null: false
    t.string "name_sv", null: false
    t.boolean "main_document", default: false, null: false
    t.string "version_id"
    t.string "source_id"
    t.index ["version_id"], name: "index_labour_market_documents_on_version_id"
  end

  create_table "labour_market_organisation_memberships", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "parent_id"
    t.string "child_id"
    t.index ["child_id"], name: "index_labour_market_organisation_memberships_on_child_id"
    t.index ["parent_id"], name: "index_labour_market_organisation_memberships_on_parent_id"
  end

  create_table "labour_market_organisations", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_sv", null: false
    t.string "slug"
    t.text "description_en"
    t.string "website"
    t.integer "organisation_type"
    t.string "name_en"
    t.text "description_sv"
    t.index ["name_en"], name: "index_labour_market_organisations_on_name_en"
    t.index ["name_sv"], name: "index_labour_market_organisations_on_name_sv"
    t.index ["organisation_type"], name: "index_labour_market_organisations_on_organisation_type"
    t.index ["slug"], name: "index_labour_market_organisations_on_slug", unique: true
  end

  create_table "mailing_list_emails", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "sent_at"
    t.string "list_id"
    t.string "subject_en"
    t.string "subject_sv"
    t.string "markdown_en"
    t.string "markdown_sv"
    t.index ["list_id"], name: "index_mailing_list_emails_on_list_id"
  end

  create_table "mailing_list_lists", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "sendgrid_id", null: false
    t.string "segment_id_en"
    t.string "segment_id_sv"
    t.string "segment_id_testers"
    t.index ["name"], name: "index_mailing_list_lists_on_name", unique: true
  end

  create_table "mailing_list_subscriptions", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.integer "sendgrid_status"
    t.string "ip_address"
    t.string "user_agent"
    t.string "accept_language"
    t.integer "turnstile_status"
    t.string "list_id"
    t.index ["list_id"], name: "index_mailing_list_subscriptions_on_list_id"
  end

  create_table "media_images", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
  end

  create_table "policy_documents", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_policy_documents_on_slug", unique: true
  end

  create_table "policy_revisions", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "document_id"
    t.string "title_en"
    t.string "title_sv"
    t.string "body_en"
    t.string "body_sv"
    t.index ["document_id", "created_at"], name: "index_policy_revisions_on_document_id_and_created_at"
    t.index ["document_id"], name: "index_policy_revisions_on_document_id"
  end

  create_table "social_media_accounts", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "url", null: false
    t.integer "provider", null: false
    t.integer "rank", null: false
    t.index ["rank"], name: "index_social_media_accounts_on_rank"
  end

  create_table "user_accounts", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_user_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_accounts_on_reset_password_token", unique: true
  end

  create_table "user_authorizations", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account_id"
    t.string "role_id"
    t.index ["account_id"], name: "index_user_authorizations_on_account_id"
    t.index ["role_id"], name: "index_user_authorizations_on_role_id"
  end

  create_table "user_roles", id: :string, default: -> { "ULID()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "description", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "labour_market_agreement_memberships", "labour_market_agreements", column: "agreement_id"
  add_foreign_key "labour_market_agreement_memberships", "labour_market_organisations", column: "organisation_id"
  add_foreign_key "labour_market_agreement_versions", "labour_market_agreements", column: "agreement_id"
  add_foreign_key "labour_market_documents", "labour_market_agreement_versions", column: "version_id"
  add_foreign_key "labour_market_documents", "labour_market_bookmarks", column: "source_id"
  add_foreign_key "labour_market_organisation_memberships", "labour_market_organisations", column: "child_id"
  add_foreign_key "labour_market_organisation_memberships", "labour_market_organisations", column: "parent_id"
  add_foreign_key "mailing_list_emails", "mailing_list_lists", column: "list_id"
  add_foreign_key "mailing_list_subscriptions", "mailing_list_lists", column: "list_id"
  add_foreign_key "policy_revisions", "policy_documents", column: "document_id"
  add_foreign_key "user_authorizations", "user_accounts", column: "account_id"
  add_foreign_key "user_authorizations", "user_roles", column: "role_id"
end
