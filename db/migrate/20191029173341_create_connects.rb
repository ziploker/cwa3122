class CreateConnects < ActiveRecord::Migration[6.0]
  def change
    create_table :connects do |t|
      t.text :ip

      t.timestamps
    end
  end
end
