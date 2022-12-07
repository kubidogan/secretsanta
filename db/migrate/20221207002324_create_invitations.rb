class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :accepted

      t.timestamps
    end
  end
end
