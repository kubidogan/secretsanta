class CreateDraws < ActiveRecord::Migration[7.0]
  def change
    create_table :draws do |t|
      t.integer :group_id
      t.integer :giver_id
      t.integer :receiver_id

      t.timestamps
    end
  end
end
