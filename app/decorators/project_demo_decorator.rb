require_dependency 'application_decorator'
class ProjectDemoDecorator < ApplicationDecorator
  delegate :projects, to: :model

  protected
  def attributes_for_output
    %w(name demo_at window_closes_at description status)
  end

end
