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
        assists: {
          include: {
            player: {
              only: [:id, :name]
            }
          }
        },
        on_ices: {
          include: {
            player: {
              only: [:id, :name]
            }
          }
        }
      }
    }
    @goal.to_json(options)
  end

end