class CreateIpaddies < ActiveRecord::Migration[6.0]
  def change
    create_table :ipaddies do |t|
      t.string :ip

      t.timestamps
    end
  end
end
