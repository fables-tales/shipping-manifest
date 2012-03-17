class AddShipVotes < ActiveRecord::Migration
  def change
    add_column :ships, :votes, :int 
  end
end
