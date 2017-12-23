class Admin::Base < ApplicationController
	private
	def current_administrator
		if session[:administator_id]
			@current_administrator ||=
				Administrator.find_by(id: session[:administator_id])
		end
	end

	helper_method :current_administrator
end