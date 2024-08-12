# frozen_string_literal: true

# This class used to create messages table
class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :conversation
      t.references :sender
      t.text :body

      t.timestamps
    end
  end
end
