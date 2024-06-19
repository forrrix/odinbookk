class CreateFollowRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_requests do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.references :followee, null: false, foreign_key: { to_table: :users }
      t.string :status, null: false

      t.timestamps
    end
    add_index :follow_requests, [:follower_id, :followee_id], unique: true
  end
end
