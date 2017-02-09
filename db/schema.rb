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

ActiveRecord::Schema.define(version: 20170207085631) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "omschrijving"
    t.decimal  "prijs"
    t.string   "eenheid"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "calculations", force: :cascade do |t|
    t.string   "werkbon"
    t.string   "ruimte"
    t.decimal  "aantal"
    t.decimal  "breedte"
    t.decimal  "hoogte"
    t.string   "strakke_hoogte_maat"
    t.boolean  "bmdm"
    t.string   "stuks"
    t.decimal  "hoofdje"
    t.decimal  "rail_lengte"
    t.string   "montage"
    t.boolean  "bediening"
    t.decimal  "montage_hoogte"
    t.string   "plaatsing"
    t.boolean  "bed"
    t.string   "raam_type"
    t.boolean  "uitlijnen"
    t.integer  "vloer_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "knipmaat"
    t.string   "bocht_type"
    t.string   "bocht_maat"
    t.string   "snijmaat"
    t.string   "ondervloer"
    t.string   "legrichting"
    t.string   "type_roede"
    t.string   "pakket"
    t.string   "zijgeleiding"
    t.string   "contra_rolend"
    t.string   "koof"
    t.string   "raam_montage"
    t.string   "uitlijnen_met"
    t.boolean  "tuimelkoord"
    t.decimal  "raam_prijs"
    t.string   "ondergrond"
    t.boolean  "voorstrijken"
  end

  add_index "calculations", ["vloer_id"], name: "index_calculations_on_vloer_id", using: :btree

  create_table "dropdowns", force: :cascade do |t|
    t.string   "input"
    t.integer  "regel_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "article_type"
  end

  add_index "dropdowns", ["regel_id"], name: "index_dropdowns_on_regel_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.decimal  "hoeveelheid"
    t.string   "omschrijving"
    t.string   "var1"
    t.string   "var1_name"
    t.string   "var2"
    t.string   "var2_name"
    t.string   "var3"
    t.string   "var3_name"
    t.string   "var4"
    t.string   "var4_name"
    t.decimal  "article_prijs"
    t.decimal  "prijs"
    t.decimal  "totale_prijs"
    t.decimal  "totale_arbeid"
    t.string   "werkbon_type"
    t.integer  "vloer_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "ref_id"
  end

  add_index "items", ["vloer_id"], name: "index_items_on_vloer_id", using: :btree

  create_table "leverancier_regels", force: :cascade do |t|
    t.string   "input"
    t.integer  "leverancier_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "leverancier_regels", ["leverancier_id"], name: "index_leverancier_regels_on_leverancier_id", using: :btree

  create_table "leveranciers", force: :cascade do |t|
    t.string   "leverancier_werkbon"
    t.string   "leverancier_label"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "voorraad_actie"
    t.integer  "sequence_id"
  end

  create_table "order_states", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_states", ["order_id"], name: "index_order_states_on_order_id", using: :btree

  create_table "order_statuses", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "order_statuses", ["order_id"], name: "index_order_statuses_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "naam"
    t.string   "project_nummer"
    t.string   "project_naam"
    t.string   "AdressLine1"
    t.string   "AdressLine3"
    t.string   "AdressLine4"
    t.string   "telefoon"
    t.string   "email"
    t.string   "contactpersoon"
    t.string   "oplevering"
    t.string   "ordernummer"
    t.decimal  "totale_prijs",    default: 0.0
    t.decimal  "totale_arbeid",   default: 0.0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "navigatie_adres"
    t.string   "inmeetdatum"
    t.integer  "status"
  end

  create_table "regels", force: :cascade do |t|
    t.string   "werkbon"
    t.string   "article_type"
    t.string   "leverancier_name"
    t.string   "label"
    t.string   "var_1_eenheid"
    t.string   "var_2_eenheid"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "ref_id"
  end

  create_table "second_dropdowns", force: :cascade do |t|
    t.string   "input"
    t.integer  "regel_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "article_type"
  end

  add_index "second_dropdowns", ["regel_id"], name: "index_second_dropdowns_on_regel_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "fullname"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "failed_attempts",        default: 0,  null: false
    t.datetime "locked_at"
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vloers", force: :cascade do |t|
    t.integer  "organisatie"
    t.string   "datum"
    t.string   "werkvoorbereider"
    t.string   "werkbon_type"
    t.decimal  "totale_prijs",     default: 0.0
    t.decimal  "totale_arbeid",    default: 0.0
    t.text     "bijzonderheden"
    t.integer  "status",           default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "backup"
    t.integer  "order_state_id"
    t.string   "name"
  end

  add_index "vloers", ["order_state_id"], name: "index_vloers_on_order_state_id", using: :btree

  add_foreign_key "calculations", "vloers"
  add_foreign_key "dropdowns", "regels"
  add_foreign_key "items", "vloers"
  add_foreign_key "leverancier_regels", "leveranciers"
  add_foreign_key "order_states", "orders"
  add_foreign_key "order_statuses", "orders"
  add_foreign_key "second_dropdowns", "regels"
end
