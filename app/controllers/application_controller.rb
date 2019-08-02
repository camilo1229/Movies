class ApplicationController < ActionController::API
	
	protected
		def authenticate
			if request.headers.include?('token')
				@token_decode = Auth.decode_token(request.headers['token'].split(" ")[1])
				unless @token_decode.status == :ok
					return render json: { message: @token_decode.message }, status: @token_decode.status
				end
				unless current_user
					return render json: { message: "User not found" }, status: :not_found
				end
			else
				render json: { message: "Token is required" }, status: :bad_request
			end
		end

		def current_user
			if @current_user = User.find_by(id: @token_decode.data)
				return true
			end
			false
		end
end
