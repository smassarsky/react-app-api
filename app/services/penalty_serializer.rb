class PenaltySerializer

  def initializer(penalty_obj)
    @penalty = penalty_obj
  end

  def to_serialized_json
    options = {
      only: [:id, :period, :time, :length, :infraction],
      include: {
        player: {
          only: [:id, :name]
        },
        team: {
          only: [:id, :name]
        }
      }
    }
    @penalty.to_json(options)
  end

end