# frozen_string_literal: true

# This class serve as blueprint for message model
class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: 'User'
end
