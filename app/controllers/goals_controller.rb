class GoalsController < ApplicationController

  def create
    game = Game.find_by(id: params[:goal][:game_id])
    if exists_and_owner?(game)
      goal = Goal.new(goal_params)
      if goal.save
        render json: GoalSerializer.new(goal).to_serialized_json
      else
        render json: { error: goal.errors.full_messages }, status: :bad_request
      end
    end
  end

  def update
    goal = Goal.find_by(id: params[:id])
    if exists_and_owner?(goal)
      if goal.update(goal_params)
        render json: GoalSerializer.new(goal).to_serialized_json
      else
        render json: { error: goal.errors.full_messages }, status: :bad_request
      end
    end
  end

  def destroy
    goal = Goal.find_by(id: params[:id])
    if exists_and_owner?(goal)
      goal.destroy
      render json: { success: "Goal Deleted" }
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:game_id, :player_id, :team_id, :period, :time, :assist_player_ids => [], :on_ice_player_ids => [])
  end

end