class AddDefaultValueToApprovedAttribute < ActiveRecord::Migration[6.0]
	def change

	#That's the more generic way to change a column
		def up
			change_column :users, :approved, :boolean, default: false
		end

		def down
			change_column :users, :approved, :boolean, default: nil
		end
	end
end
