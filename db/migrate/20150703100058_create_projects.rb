class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.integer :project_demo_id
      t.string :name
      t.string :source_url
      t.string :description
      t.string :month

      t.timestamps null: false
    end
  end
end
