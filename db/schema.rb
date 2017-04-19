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

ActiveRecord::Schema.define(version: 20161211163129) do

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "logo"
    t.string   "siret"
    t.string   "location"
    t.string   "description"
    t.string   "address"
    t.string   "phone"
    t.string   "lat"
    t.string   "lng"
    t.integer  "company_id_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["company_id_id"], name: "index_companies_on_company_id_id", using: :btree
    t.index ["user_id"], name: "index_companies_on_user_id", using: :btree
  end

  create_table "discounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "level"
    t.string   "success"
    t.string   "fail"
    t.boolean  "state"
    t.string   "game_ref"
    t.integer  "game_id"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_discounts_on_company_id", using: :btree
    t.index ["game_id"], name: "index_discounts_on_game_id", using: :btree
  end

  create_table "game_lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.string   "image"
    t.text     "level",       limit: 65535
    t.text     "share",       limit: 65535
    t.text     "string",      limit: 65535
    t.integer  "game_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["game_id"], name: "index_game_lists_on_game_id", using: :btree
  end

  create_table "games", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ref"
    t.string   "name"
    t.string   "description"
    t.string   "logo"
    t.string   "image"
    t.string   "color1"
    t.string   "color2"
    t.string   "perso1"
    t.string   "perso2"
    t.string   "custom"
    t.string   "vuforia_name"
    t.integer  "company_id"
    t.integer  "target_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["company_id"], name: "index_games_on_company_id", using: :btree
    t.index ["target_id"], name: "index_games_on_target_id", using: :btree
  end

  create_table "games_targets", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "game_id",   null: false
    t.integer "target_id", null: false
    t.index ["game_id", "target_id"], name: "index_games_targets_on_game_id_and_target_id", using: :btree
  end

  create_table "scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "target_id"
    t.string   "player_id"
    t.string   "game_id"
    t.string   "success"
    t.string   "score"
    t.string   "lieu"
    t.string   "location_gps"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["target_id"], name: "index_scores_on_target_id", using: :btree
    t.index ["user_id"], name: "index_scores_on_user_id", using: :btree
  end

  create_table "targets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "vuforia_name"
    t.string   "transaction_id"
    t.string   "target_id"
    t.string   "image"
    t.string   "path"
    t.string   "place"
    t.string   "city"
    t.string   "discountChance"
    t.string   "discountRate"
    t.integer  "company_id"
    t.integer  "game_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["company_id"], name: "index_targets_on_company_id", using: :btree
    t.index ["game_id"], name: "index_targets_on_game_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "company_name",    default: "", null: false
    t.string   "user_name",       default: "", null: false
    t.string   "first_name",      default: "", null: false
    t.string   "last_name",       default: "", null: false
    t.string   "adress",          default: "", null: false
    t.string   "image",           default: "", null: false
    t.string   "token",           default: "", null: false
    t.string   "phone",           default: "", null: false
    t.string   "function",        default: "", null: false
    t.string   "about",           default: "", null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

end
