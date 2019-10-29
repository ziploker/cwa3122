class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.text :session

      t.timestamps
    end
  end
end
