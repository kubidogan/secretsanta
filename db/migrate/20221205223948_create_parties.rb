class CreateParties < ActiveRecord::Migration[7.0]
  def change
    create_table :parties do |t|
      t.string :title
      t.text :description
      t.datetime :event_date
      t.string :location
      t.integer :user_id

      t.timestamps
    end
    add_index :parties, :user_id
  end
end
