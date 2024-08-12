# frozen_string_literal: true

# This class set messages to show in conversation layout
class ConversationsController < ApplicationController
  before_action :correct_user
  before_action :current_user_param, only: :show
  before_action :other_user, only: :show
  before_action :self_user, only: :show
  before_action :valid_user_conversation, only: :show
  before_action :authenticate_user


  def show
    @conversation = if Conversation.find_by(user2: @current_user.id, user1: @user.id)
                      Conversation.find_by(user2: @current_user, user1: @user.id)
                    else
                      Conversation.find_or_create_by(user1: @current_user, user2: @user)
                    end

    @messages = @conversation.messages.order(created_at: :asc)
    @message = Message.new
  end

  private

  def current_user_param
    @current_user = User.find(params[:id])
  end

  def other_user
    @user = User.find(params[:other_user_id])
  end

  def self_user
    redirect_to current_user if params[:id] == params[:other_user_id]
  end

  def  valid_user_conversation
    if !valid_relation?(other_user)
      seller_or_buyer = if current_user.seller?
                          "Seller"
                        else
                          "Buyer"
                        end
      flash[:danger] = "#{seller_or_buyer} cannot start a conversation with #{seller_or_buyer}"
      p current_user
      redirect_to users_path
    end
  end

  def authenticate_user
    if !logged_in?
      flash[:danger] = "You'r not logged in!"
      redirect_to root_path
    end
  end

  def correct_user
    @user_check = User.find(params[:id])
    unless @user_check == current_user
      flash[:danger] = "You'r not a correct user!"
      redirect_to root_path
    end
  end
end
