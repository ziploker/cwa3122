class DropTableAgain < ActiveRecord::Migration[6.0]
  def change
  	drop_table :ipaddies
  end
end
