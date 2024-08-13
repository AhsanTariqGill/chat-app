# frozen_string_literal: true

module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    return unless logged_in?

    user.id == current_user.id
  end

  def get_conversation(other_user)
    @conversation = Conversation.find_by(user1: current_user.id,
                                         user2: other_user.id) || Conversation.find_by(
                                           user2: current_user.id, user1: other_user.id
                                         )
  end

  def conversation?(other_user)
    @conversation = Conversation.find_by(user1: current_user.id,
                                         user2: other_user.id) || Conversation.find_by(
                                           user2: current_user.id, user1: other_user.id
                                         )
    !@conversation.nil?
  end

  def get_request(other_user)
    @request = Request.find_by(sender_id: current_user.id,
                               receiver_id: other_user.id) || Request.find_by(
                                 sender_id: current_user.id, receiver_id: other_user.id
                               )
  end

  def valid_relation?(other_user)
    if current_user.seller? && !other_user.seller?
      puts 'I am seller'
      true
    elsif !current_user.seller? && other_user.seller?
      puts 'I am buyer I am here'
      true
    elsif current_user.seller? && other_user.seller?
      false
    elsif !current_user.seller? && !other_user.seller?
      false
    end
  end

  def seller_and_buyer
    if current_user.seller?
      'Buyers'
    else
      'Sellers'
    end
  end

  def is_admin?
    if current_user
      current_user.admin?
    else
      false
    end
  end

  def is_approved?(conversation)
    if conversation
      conversation.approve?
    else
      false
    end
  end

  def approval_pending?(request)
    if request
      request.approve?
    else
      true
    end
  end
end
