class StaffMember < ActiveRecord::Base
	before_validation do
		self.email_for_index = email.downcase if email
	end

	def password=(raw_password)
		if raw_password.kind_of?(String)
			self.hashed_password = BCrypt::Password.create(raw_password)
		elsif raw_password.nil?
			self.hashed_password = nil
		end
	end

	# 強制ログアウトの判定のため、職員アカウントの有効/無効を判定する
	def active?
		!suspended? && start_date <= Date.today &&
			(end_date.nil? || end_date > Date.today)
	end
end
