# frozen_string_literal: true

class Request < ApplicationRecord
  def approve_request(conversation)
    update_attribute(:approve, true)
    conversation.approval
  end
end
