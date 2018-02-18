module EmailHolder
  extend ActiveSupport::Concern

  included do
    include StringNormalizer

    before_validation do
      self.email = normalize_as_email(email)
      self.email_for_index = email.downcase if email
    end

    validates :email, presence: true, email: { allow_blank: true }
    validates :email_for_index, uniqueness: { allow_blank: true }
    # emailの重複チェック、小文字変換後のemail_for_indexで重複チェックし、
  	# email属性にエラーを付与する(エラーが発生している属性の入れ替えをする)
  	# 画面にエラーが発生していることを表示するため。
    after_validation do
      if errors.include?(:email_for_index)
        errors.add(:email, :taken)
        errors.delete(:email_for_index)
      end
    end
  end
end
