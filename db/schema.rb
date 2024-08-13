# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_240_812_064_714) do
  create_table 'conversations', force: :cascade do |t|
    t.integer 'user1_id', null: false
    t.integer 'user2_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'approve', default: false
    t.index ['user1_id'], name: 'index_conversations_on_user1_id'
    t.index ['user2_id'], name: 'index_conversations_on_user2_id'
  end

  create_table 'messages', force: :cascade do |t|
    t.integer 'conversation_id'
    t.integer 'sender_id'
    t.text 'body'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['conversation_id'], name: 'index_messages_on_conversation_id'
    t.index ['sender_id'], name: 'index_messages_on_sender_id'
  end

  create_table 'requests', force: :cascade do |t|
    t.integer 'sender_id'
    t.integer 'receiver_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'approve', default: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'seller', default: false
    t.string 'email'
    t.string 'password_digest'
    t.boolean 'admin', default: false
  end

  add_foreign_key 'conversations', 'users', column: 'user1_id'
  add_foreign_key 'conversations', 'users', column: 'user2_id'
end
