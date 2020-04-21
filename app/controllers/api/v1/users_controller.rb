class Api::V1::UsersController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user.nil?
      new_user = User.create(user_params)
      render json: UsersSerializer.new(new_user), status: 201
    else
      render json: {status: 400, text: 'Invalid credentials.'}
    end
  end

  private
    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
end
