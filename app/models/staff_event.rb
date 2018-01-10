class StaffEvent < ActiveRecord::Base
  self.inheritance_column = nil # typeカラムが持つ特別な意味を無効にする

  belongs_to :member, class_name: 'StaffMember', foreign_key: 'staff_member_id'
  alias_attribute :occured_at, :created_at
end
