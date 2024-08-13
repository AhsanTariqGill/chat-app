# frozen_string_literal: true

class AddApproveToConversations < ActiveRecord::Migration[6.0]
  def change
    add_column :conversations, :approve, :boolean, default: false
  end
end
