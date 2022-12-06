class AddPeopleToParties < ActiveRecord::Migration[7.0]
  def change
    add_column :parties, :people, :string
  end
end
