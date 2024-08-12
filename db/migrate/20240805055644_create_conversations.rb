# frozen_string_literal: true

# This class used to create conversation table
class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.references :user1, foreign_key: { to_table: :users }, null: false
      t.references :user2, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
