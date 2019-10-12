class CreatePools < ActiveRecord::Migration[6.0]
  def change
    create_table :pools do |t|
      t.string :first_name
      t.string :last_name
      t.string :uid

      t.timestamps
    end
  end
end
