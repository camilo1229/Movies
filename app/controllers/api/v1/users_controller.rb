class Api::V1::UsersController < ApplicationController
  before_action :authenticate
  
  def profile
    render json: @current_user.profile_details
  end

  def update
    if @current_user.update_attributes(user_params)
			render json: { user: @current_user.profile_details, message: 'Updated user info' }
		else
			render json: { message: @current_user.errors.full_messages.to_sentence }, status: :unprocessable_entity
		end
	end

	private
		def user_params
    	params.require(:user).permit(:email, :name, :last_name, :phone, :avatar)
		end
end
