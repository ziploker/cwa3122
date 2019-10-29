class DropTables < ActiveRecord::Migration[6.0]
  def change

  	drop_table :connects
  	drop_table :ip_addresses

  end
end
