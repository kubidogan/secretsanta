class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.integer :parties_id

      t.timestamps
    end
    add_index :members, :parties_id
  end
end
