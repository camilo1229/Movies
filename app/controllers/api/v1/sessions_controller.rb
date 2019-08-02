class Api::V1::SessionsController < ApplicationController

	# Autor: Juan Camilo
	#
	# Fecha creacion: 2019-01-08
	#
	# Fecha actualizacion: 
	#
	# Metodo: Create - User sign up.
	#
	# Parámetros: session_params --> strong parameters
	def create
		user = User.new(session_params)
		if user.save
			render json: { token: Auth.create_token(user.id, false), message: "User created" }, status: :ok
		else
			render json: { message: user.errors.full_messages }, status: :unprocessable_entity
		end
	end

	
	# Autor: Juan Camilo
	#
	# Fecha creacion: 2019/02/08
	#
	# Fecha actualizacion: 
	#
	# Metodo: Post - Iniciar sesión con email y contraseña
	#
	# URL: /login
	#
	# Resultado: Si las credenciales de acceso son correctas retorna datos usuario
	# + token, sino mensajes indicando el error.
	#
	def login
		if user = User.find_by(email: params[:email])
			if user.active?
				if user.validate_password(params[:password])
					render json: { 
						user: user.attributes.slice("id","name", "last_name", "email", "avatar"),
						token: Auth.create_token(user.id, false), 
						message: "Login success"
						}, status: :ok
				else
					render json: { message: "Invalid password" }, status: :forbidden
				end
			else
				render json: { message: "User disabled" }, status: :unauthorized
			end
		else
			render json: {message: "User not found"}, status: :not_found
		end		
	end

	private
		def session_params
			params.require(:user).permit(:email, :password, :password_confirmation, :name, :last_name, :phone, :avatar)
		end
end
