class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :configure_devise_params, if: :devise_controller?

	def configure_devise_params
		devise_parameter_sanitizer.permit(:sign_up) do |user|
			user.permit(:name, :email, :password, :password_confirmation)
		end
	end

	def after_sign_in_path_for(resource)
		posts_path
	end

	def like_exists?(user_id, post_id)
		Like.where(user_id: user_id, post_id: post_id).exists?
	end

end
