# frozen_string_literal: true

# This class handles creation of messages
class MessagesController < ApplicationController
  before_action :fetch_coversation, only: :create
  before_action :fetch_current_user, only: :create
  before_action :authenticate_user

  def create
    @message = @conversation.messages.create(message_params.merge(sender: @current_user))

    if @message.save
      redirect_to chat_with_user_path(@current_user, Conversation.receiver(@conversation, @current_user))
    else
      render 'conversations/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def fetch_coversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def fetch_current_user
    @current_user = User.find(params[:message][:current_user_id])
  end

  def authenticate_user
    return if logged_in?

    flash[:danger] = "You'r not logged in!"
    redirect_to root_path
  end
end
