class CreateIps < ActiveRecord::Migration[6.0]
  def change
    create_table :ips do |t|
      t.string :ipaddy

      t.timestamps
    end
  end
end
