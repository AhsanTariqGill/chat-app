# frozen_string_literal: true

# This class serve as blueprint for user model
class User < ApplicationRecord
  has_secure_password
  has_many :conversations_as_user1, class_name: 'Conversation', foreign_key: 'user1_id'
  has_many :conversations_as_user2, class_name: 'Conversation', foreign_key: 'user2_id'

  def become_seller
    update_attribute(:seller, true)
  end
end
