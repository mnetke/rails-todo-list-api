# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: :create

  # POST /user
  def create
    user = User.new(user_params)
    if user.valid?
      user.save!
      UserMailer.example(User.new(email: user.email)).deliver
      render json: { msg: 'User craeted successfully' }
    else
      render json: { error: user.errors }, status: :unauthorized
    end
  end

  # GET /user/:id
  def show
    if params[:id].to_i == current_user.id
      render json: { status: 200, message: 'User details', data: current_user }
    else
      render json: { errors: ['1.Token and user id mismatch', '2.Create token first to access this user.'] }, status: 400
    end
  end

      private

  attr_reader :current_user

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
