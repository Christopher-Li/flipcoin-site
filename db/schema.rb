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

ActiveRecord::Schema.define(version: 20170908065010) do

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstName"
    t.string "lastName"
    t.string "password_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "ethAdd"
    t.string "bitAdd"
    t.decimal "estimatedContribution"
    t.string "phoneNumber"
    t.string "address1"
    t.string "address2"
    t.string "state"
    t.string "zipCode"
    t.string "city"
    t.date "dob"
    t.string "contract_digest"
    t.boolean "isEntity"
    t.string "citizenship"
    t.string "socialSecurity"
    t.string "organizationType"
    t.string "equityOwners"
    t.string "entityType"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
