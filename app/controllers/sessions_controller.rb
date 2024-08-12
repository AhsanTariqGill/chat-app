class SessionsController < ApplicationController
	def new; end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user&.authenticate(params[:session][:password])
			log_in user
			if is_admin?
				redirect_to admin_root_path
			else
				redirect_to user
			end
		else
			flash[:danger] = "Invalid email/password"
			render :new
		end

	end

	def destroy
		log_out
		redirect_to root_path
	end
end
