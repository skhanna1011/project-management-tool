class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :upvote_count
      t.integer :downvote_count
      t.integer :total

      t.timestamps null: false
    end
  end
end
