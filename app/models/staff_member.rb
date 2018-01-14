class StaffMember < ActiveRecord::Base
	include StringNormalizer

	has_many :events, class_name: 'StaffEvent', dependent: :destroy

	before_validation do
		self.email = normalize_as_email(email)
		self.email_for_index = email.downcase if email
		self.family_name = normalize_as_name(family_name)
		self.given_name = normalize_as_name(given_name)
		self.family_name_kana = normalize_as_furigana(family_name_kana)
		self.given_name_kana = normalize_as_furigana(given_name_kana)
	end

	KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/
	HUMAN_NAME_REGEXP = /\A[\p{han}\p{hiragana}\p{katakana}\u{30fc}\p{alpha}]+\z/

	validates :email, presence: true, email: { allow_blank: true }
	validates :family_name, :given_name, presence: true,
	 format: { with: HUMAN_NAME_REGEXP }
	validates :family_name_kana, :given_name_kana, presence: true,
	 format: { with: KATAKANA_REGEXP, allow_blank: true } # allow_blank : 空白の場合はvalidationしない
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

	# emailの重複チェック、小文字変換後のemail_for_indexで重複チェックし、
	# email属性にエラーを付与する(エラーが発生している属性の入れ替えをする)
	# 画面にエラーが発生していることを表示するため。
	validates :email_for_index, uniqueness: { allow_blank: true }
	after_validation do
		if errors.include?(:email_for_index)
			errors.add(:email, :taken) # 第1引数 : エラーを付与する属性、第2引数 : メッセージ
			errors.delete(:email_for_index)
		end
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
