# frozen_string_literal: true

# This class can be used to write code for email
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
