class RenameColumsToAdministrators < ActiveRecord::Migration
  def change
  	rename_column :administrators, :supended, :suspended
  end
end
