class DropPartiesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :parties
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
