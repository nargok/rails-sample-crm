class ChangeDatatypeDateOfStaffMembers < ActiveRecord::Migration
  def change
  	change_column :staff_members, :start_date, :date
  	change_column :staff_members, :end_date, :date
  end
end
