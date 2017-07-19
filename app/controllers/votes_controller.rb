class VotesController < ApplicationController
  def index
  end

  def create
    if can_vote
      vote.assign_attributes(create_params)
      if vote.save
        redirect_to project_demos_latest_path
      else
        render json: { errors: vote.errors }
      end
    else
      redirect_to project_demos_latest_path, flash: { info: "Not eligible to vote for your own project or more than 3 projects!" }
    end
  end

  def delete
    Vote.where(user_id: current_user.id, project_id: params[:project_id]).delete_all
    redirect_to project_demos_latest_path
  end

  private

  def create_params
    @_create_params ||= params.permit(:project_id, :status).merge!(user_id: current_user.id).merge!(vote_params)

  end

  def vote_params
    return {} unless can_vote
    upvote = params[:type] == 'upvote' ? vote.upvote_count + 1 : vote.upvote_count || 0
    downvote = params[:type] == 'downvote' ? vote.downvote_count + 1 : vote.downvote_count || 0
    total = (upvote - downvote) < 0 ? 0 : (upvote - downvote)
    @_vote_params ||= {
      upvote_count: upvote,
      downvote_count: downvote,
      total: total,
    }
  end

  def vote
    @_vote ||= Vote.find_by(user_id: current_user.id, project_id: params[:project_id]) || Vote.new(upvote_count: 0, downvote_count: 0, total: 0)
  end

  def can_vote
    project = Project.find(params[:project_id])
    return false if project.user_id == current_user.id
    project_ids = project.project_demo.projects.map(&:id)
    Vote.where(user_id: current_user.id, project_id: project_ids).count >= 3 ? false : true
  end


end
