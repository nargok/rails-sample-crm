class RemaneEndDateColumnToStaffMembers < ActiveRecord::Migration
  def change
  	rename_column :staff_members, :end_data, :end_date
  end
end
