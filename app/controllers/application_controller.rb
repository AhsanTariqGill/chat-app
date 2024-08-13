# frozen_string_literal: true

# This class serves as base class for all other controllers
class ApplicationController < ActionController::Base
  include SessionsHelper
end
