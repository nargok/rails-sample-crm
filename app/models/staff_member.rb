class StaffMember < ActiveRecord::Base
	include EmailHolder
	include PersonalNameHolder
	include PasswordHolder

	has_many :events, class_name: 'StaffEvent', dependent: :destroy

	# validates :email, presence: true, email: { allow_blank: true }
	# 開始日は2000/1/1以降, 今日から1年後の日付より前
	validates :start_date, presence: true, date: {
		after_or_equal_to: Date.new(2000, 1,1),
		before: -> (obj) { 1.year.from_now.to_date },
		allow_blank: true
	}
	# 終了日は開始日より後、今日から1年前後よりも前、空白でもよしとする
	validates :end_date, date: {
		after: :start_date,
		before: -> (obj) { 1.year.from_now.to_date },
		allow_blank: true
	}

	# 強制ログアウトの判定のため、職員アカウントの有効/無効を判定する
	def active?
		!suspended? && start_date <= Date.today &&
			(end_date.nil? || end_date > Date.today)
	end
end
