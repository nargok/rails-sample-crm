class StaffEvent < ActiveRecord::Base
  self.inheritance_column = nil # typeカラムが持つ特別な意味を無効にする

  belongs_to :member, class_name: 'StaffMember', foreign_key: 'staff_member_id'
  alias_attribute :occured_at, :created_at

  # type属性のデコード処理のための定数
  DESCTIPTIONS = {
    logged_in: 'ログイン',
    logged_out: 'ログアウト',
    rejected: 'ログイン拒否'
  }

  # type属性のデコード処理
  def description
    DESCTIPTIONS[type.to_sym] # シンボル化する
  end
end
