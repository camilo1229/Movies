class Api::V1::MoviesController < ApplicationController
	before_action :authenticate, except: [:index, :search]
	before_action :set_movie, only: [:show, :update, :destroy, :enable, :disable]
	before_action :authenticate_owner!, only: [:update, :destroy, :enable, :disable]

	# GET /movies
	def index
		@movies = Movie.active.includes(:user).collect(&:small_details)
		render json: @movies
	end

	# GET /movies/1
	def show
		render json: @movie.details
	end

	def my
		render json: { movies: @current_user.movies.collect(&:details) }, status: :ok
	end

	# POST /movies
	def create
		@movie = @current_user.movies.new(movie_params)
		if @movie.save
			render json: {message: "Movie created", movie: @movie.details}, status: :created
		else
			render json: {message: @movie.errors.full_messages.to_sentence}, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /movies/1
	def update
		if @movie.update(movie_params)
			render json: {message: "Movie updated", movie: @movie.details}, status: :ok
		else
			render json: {message: @movie.errors.full_messages.to_sentence }, status: :unprocessable_entity
		end
	end

	def enable
		if @movie.may_enable?
			@movie.enable!
			render json: {message: "Movie enabled", movie: @movie}, status: :ok
		else
			head :ok
		end
	end

	def disable
		if @movie.may_disable?
			@movie.disable!
			render json: {message: "Movie disabled", movie: @movie}, status: :ok
		else
			head :ok
		end
	end

	def search
		movies = Movie.by_day(params[:date])
		render json: { movies: movies.collect(&:small_details) }
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_movie
			if !@movie = Movie.find_by(id: params[:id])
			 render json: {message: "Invalid params"}, status: :bad_request
			end
		end

		def authenticate_owner!
			if @movie.user_id != @current_user.id
				return render json: {message: "You do not have permissions to perform this action"}, status: :unauthorized
			end
		end

		# Only allow a trusted parameter "white list" through.
		def movie_params
			params.require(:movie).permit(:name, :description, :image, schedules_attributes: [:schedule])
		end
end
