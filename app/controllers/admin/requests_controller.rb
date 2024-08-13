# frozen_string_literal: true

module Admin
  class RequestsController < ApplicationController
    before_action :valid_user_conversation, only: :create
    before_action :logged_in_user
    before_action :admin_check, only: %i[approve show]
    before_action :request_exist, only: :create
    before_action :current_user_param, only: :create
    before_action :other_user_param, only: :create
    before_action :sender_param, only: :approve
    before_action :receiver_param, only: :approve

    def create
      @request = Request.new(sender_id: params[:id], receiver_id: params[:other_user_id])
      if @request.save
        redirect_to current_user
      else
        render :new
      end
    end

    def show
      @requests = Request.all
    end

    def approve
      @conversation = if Conversation.find_by(user2: @current_user.id, user1: @user.id)
                        Conversation.find_by(user2: @current_user, user1: @user.id)
                      else
                        Conversation.find_or_create_by(user1: @current_user, user2: @user)
                      end
      @request = Request.find(params[:id])
      @request.approve_request(@conversation)
      flash[:success] = 'Request Approved'
      redirect_to admin_requests_path
    end

    private

    def current_user_param
      @current_user = User.find(params[:id])
    end

    def other_user_param
      @user = User.find(params[:other_user_id])
    end

    def sender_param
      @current_user = User.find(params[:sender_id])
    end

    def receiver_param
      @user = User.find(params[:receiver_id])
    end

    def request_exist; end

    def admin_check
      return if is_admin?

      flash[:danger] = "You'r not an admin"
      redirect_to current_user
    end

    def logged_in_user
      return if logged_in?

      flash[:danger] = "You'r not logged in!"
      redirect_to root_path
    end

    def valid_user_conversation
      return if valid_relation?(other_user_param)

      seller_or_buyer = if current_user.seller?
                          'Seller'
                        else
                          'Buyer'
                        end
      flash[:danger] = "#{seller_or_buyer} cannot start a conversation with #{seller_or_buyer}"
      p current_user
      redirect_to users_path
    end
  end
end
