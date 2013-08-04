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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130731085915) do

  create_table "answers", :force => true do |t|
    t.integer  "exam_id"
    t.integer  "question_line_item_id"
    t.text     "data"
    t.decimal  "point",                 :precision => 8, :scale => 1
    t.text     "comment"
    t.datetime "reviewed_at"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.string   "image"
  end

  add_index "answers", ["exam_id"], :name => "index_answers_on_exam_id"
  add_index "answers", ["question_line_item_id"], :name => "index_answers_on_question_line_item_id"
  add_index "answers", ["reviewed_at"], :name => "index_answers_on_reviewed_at"

  create_table "brief_solutions", :force => true do |t|
    t.integer  "question_id"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "brief_solutions", ["question_id"], :name => "index_brief_solutions_on_question_id"

  create_table "credit_line_items", :force => true do |t|
    t.decimal  "amount",     :precision => 8, :scale => 2
    t.integer  "credit_id"
    t.integer  "order_id"
    t.integer  "stage_id"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "credit_line_items", ["credit_id"], :name => "index_credit_line_items_on_credit_id"
  add_index "credit_line_items", ["order_id"], :name => "index_credit_line_items_on_order_id"
  add_index "credit_line_items", ["stage_id"], :name => "index_credit_line_items_on_stage_id"

  create_table "credits", :force => true do |t|
    t.integer  "user_id"
    t.decimal  "start_balance", :precision => 10, :scale => 0
    t.decimal  "balance",       :precision => 10, :scale => 0
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "credits", ["user_id"], :name => "index_credits_on_user_id"

  create_table "exams", :force => true do |t|
    t.integer  "unit_id"
    t.integer  "user_id"
    t.datetime "started_at"
    t.datetime "stopped_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "state"
  end

  add_index "exams", ["state"], :name => "index_exams_on_state"
  add_index "exams", ["unit_id"], :name => "index_exams_on_unit_id"
  add_index "exams", ["user_id"], :name => "index_exams_on_user_id"

  create_table "fill_in_blank_solutions", :force => true do |t|
    t.integer  "question_id"
    t.text     "content"
    t.integer  "position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "fill_in_blank_solutions", ["position"], :name => "index_fill_in_blank_solutions_on_position"
  add_index "fill_in_blank_solutions", ["question_id"], :name => "index_fill_in_blank_solutions_on_question_id"

  create_table "grades", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "map_places", :force => true do |t|
    t.integer  "x"
    t.integer  "y"
    t.string   "version"
    t.integer  "placeable_id"
    t.string   "placeable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "map_places", ["placeable_id", "placeable_type"], :name => "index_map_places_on_placeable_id_and_placeable_type"

  create_table "matching_solutions", :force => true do |t|
    t.integer  "question_id"
    t.text     "source"
    t.text     "target"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "hashed_source"
    t.string   "hashed_target"
  end

  add_index "matching_solutions", ["hashed_source"], :name => "index_matching_solutions_on_hashed_source"
  add_index "matching_solutions", ["hashed_target"], :name => "index_matching_solutions_on_hashed_target"
  add_index "matching_solutions", ["question_id"], :name => "index_matching_solutions_on_question_id"

  create_table "multiple_choice_options", :force => true do |t|
    t.integer  "question_id"
    t.text     "content"
    t.integer  "position"
    t.string   "sequence"
    t.boolean  "correct"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "multiple_choice_options", ["correct"], :name => "index_multiple_choice_options_on_correct"
  add_index "multiple_choice_options", ["position"], :name => "index_multiple_choice_options_on_position"
  add_index "multiple_choice_options", ["question_id"], :name => "index_multiple_choice_options_on_question_id"

  create_table "orders", :force => true do |t|
    t.string   "number"
    t.decimal  "credit_quantity", :precision => 10, :scale => 0
    t.decimal  "total",           :precision => 8,  :scale => 2
    t.string   "state"
    t.integer  "user_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "orders", ["number"], :name => "index_orders_on_number"
  add_index "orders", ["state"], :name => "index_orders_on_state"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "pictures", :force => true do |t|
    t.string   "name"
    t.string   "version"
    t.string   "image"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "pictures", ["imageable_id", "imageable_type"], :name => "index_pictures_on_imageable_id_and_imageable_type"

  create_table "question_groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "position"
    t.integer  "unit_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "question_groups", ["position"], :name => "index_question_groups_on_position"
  add_index "question_groups", ["unit_id"], :name => "index_question_groups_on_unit_id"

  create_table "question_line_items", :force => true do |t|
    t.integer  "question_id"
    t.integer  "question_group_id"
    t.integer  "position"
    t.decimal  "point",             :precision => 8, :scale => 1
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  add_index "question_line_items", ["position"], :name => "index_question_line_items_on_position"
  add_index "question_line_items", ["question_group_id"], :name => "index_question_line_items_on_question_group_id"
  add_index "question_line_items", ["question_id"], :name => "index_question_line_items_on_question_id"

  create_table "questions", :force => true do |t|
    t.string   "type"
    t.text     "subject"
    t.text     "hint"
    t.integer  "level"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
  end

  add_index "questions", ["type"], :name => "index_questions_on_type"

  create_table "single_choice_options", :force => true do |t|
    t.integer  "question_id"
    t.text     "content"
    t.integer  "position"
    t.string   "sequence"
    t.boolean  "correct"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "single_choice_options", ["correct"], :name => "index_single_choice_options_on_correct"
  add_index "single_choice_options", ["position"], :name => "index_single_choice_options_on_position"
  add_index "single_choice_options", ["question_id"], :name => "index_single_choice_options_on_question_id"

  create_table "stages", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price",        :precision => 8, :scale => 2
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "video"
    t.string   "video_poster"
    t.integer  "grade_id"
  end

  add_index "stages", ["grade_id"], :name => "index_stages_on_grade_id"

  create_table "stages_users", :id => false, :force => true do |t|
    t.integer "stage_id"
    t.integer "user_id"
  end

  add_index "stages_users", ["stage_id"], :name => "index_stages_users_on_stage_id"
  add_index "stages_users", ["user_id"], :name => "index_stages_users_on_user_id"

  create_table "units", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "exam_minutes"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "stage_id"
  end

  add_index "units", ["stage_id"], :name => "index_units_on_stage_id"

  create_table "user_questions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_units", :force => true do |t|
    t.integer  "user_id"
    t.integer  "unit_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "role"
    t.string   "authentication_token"
    t.string   "avatar"
    t.string   "gender"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
