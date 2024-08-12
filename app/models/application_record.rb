# frozen_string_literal: true

# This class serve as base class for all models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
