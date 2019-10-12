class AddDefaultValueToApproved < ActiveRecord::Migration[6.0]
  def change
  	change_column :users, :approved, :boolean, :default => false
  end
end
