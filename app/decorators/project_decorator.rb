require_dependency 'application_decorator'
class ProjectDecorator < ApplicationDecorator

  protected
  def attributes_for_output
    %w(name source_url description)
  end

end
