class ProjectDemo < ActiveRecord::Base

  def self.statuses
    %w(open expired)
  end

  validates_presence_of :demo_at, :window_opens_at, :window_closes_at, :name
  validates :status, inclusion: {in: self.statuses }
  validate :valid_date
  validate :valid_submission_date
  validate :can_create_new_event, :on => :create
  has_many :projects

  private

  def valid_date
    return true if demo_at && demo_at > (Date.today.beginning_of_day + 3.days)
    self.errors.add(:base, "Give at least 3 days time for project submissions and voting before the demo date")
    false
  end

  def valid_submission_date
    return true if demo_at && window_closes_at && window_closes_at < demo_at && window_closes_at > Time.now
    self.errors.add(:base, "Project submissions date should fall before the demo date")
    false
  end

  def can_create_new_event
    latest_demo = ProjectDemo.last
    return unless latest_demo
    return true if latest_demo.demo_at < Time.now
    self.errors.add(:base, "Next project demo can only be created after the upcoming demo")
    false
  end

end

