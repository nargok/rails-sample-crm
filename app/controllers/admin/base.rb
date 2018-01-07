class Admin::Base < ApplicationController
	before_action :authorize

	private
	def current_administrator
		if session[:administator_id]
			@current_administrator ||=
				Administrator.find_by(id: session[:administator_id])
		end
	end

	helper_method :current_administrator

	def authorize
		unless current_administrator
			flash.alert = "管理者としてログインしてください。"
			redirect_to :admin_login
		end
	end
end
