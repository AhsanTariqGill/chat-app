# frozen_string_literal: true

class AddPasswordDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email, :string
    add_column :users, :password_digest, :string
    def change
      add_index :users, :email, unique: true
    end
  end
end
