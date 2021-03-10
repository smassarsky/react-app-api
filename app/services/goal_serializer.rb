class GoalSerializer

  def initialize(goal_obj)
    @goal = goal_obj
  end

  def to_serialized_json
    options = {
      only: [:id, :period, :time],
      include: {
        player: {
          only: [:id, :name]
        },
        team: {
          only: [:id, :name]
        },
        assist_players: {
          only: [:id, :name]
        },
        on_ice_players: {
          only: [:id, :name]
        }
      }
    }
    @goal.to_json(options)
  end

  def as_json
    options = {
      only: [:id, :period, :time],
      include: {
        player: {
          only: [:id, :name]
        },
        team: {
          only: [:id, :name]
        },
        assist_players: {
          only: [:id, :name]
        },
        on_ice_players: {
          only: [:id, :name]
        }
      }
    }
    @goal.as_json(options)
  end

end