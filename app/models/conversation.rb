# frozen_string_literal: true

# This class serve as blueprint for conversation model
class Conversation < ApplicationRecord
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'
  has_many :messages, dependent: :destroy

  def self.receiver(conversation, current_user)
    if conversation.user1_id == current_user.id
      conversation.user2_id
    else
      conversation.user1_id
    end
  end

  def approval
    update_attribute(:approve, true)
  end
end
