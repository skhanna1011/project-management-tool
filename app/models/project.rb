class Project < ActiveRecord::Base

  validates_presence_of :user_id, :project_demo_id, :name, :source_url
  validates :user_id, uniqueness: { scope: :project_demo_id, message: 'has already submitted project for this submission' }

  belongs_to :user
  belongs_to :project_demo
  has_many :votes
end
