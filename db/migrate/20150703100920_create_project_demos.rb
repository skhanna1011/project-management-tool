class CreateProjectDemos < ActiveRecord::Migration
  def change
    create_table :project_demos do |t|
      t.string :name
      t.date :demo_on
      t.datetime :demo_at
      t.string :description
      t.string :status
      t.datetime :window_opens_at
      t.datetime :window_closes_at
      t.string :remarks
      t.string :month

      t.timestamps null: false
    end
  end
end

# byot_on => project_on => demo_on
