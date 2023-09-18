class RemoveUserIdFromFoods < ActiveRecord::Migration[7.0]
  def change
    remove_index :foods, name: "index_foods_on_user_id" 
    remove_column :foods, :user_id, :bigint, null: false  
  end
end
