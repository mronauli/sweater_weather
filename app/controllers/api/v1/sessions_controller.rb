class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      render json: UserSerializer.new(user), status: 200
    else
      render json: {status: 400, text: 'Unauthorized'}
    end
  end
end
