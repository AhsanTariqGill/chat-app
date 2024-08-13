# frozen_string_literal: true

class AddApproveToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :approve, :boolean, default: false
  end
end
