class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.integer :person1
      t.integer :person2

      t.timestamps
    end
  end
end
