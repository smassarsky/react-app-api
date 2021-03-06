class GameSerializer

  def initialize(game_obj)
    @game = game_obj
  end

  def to_serialized_json
    options = {
      only: [:id, :datetime, :opponent, :status, :place],
      methods: [:score]
    }
    @game.to_json(options)
  end

  def show_to_serialized_json
    options = {
      only: [:id, :datetime, :opponent, :status, :place],
      include: {
        goals: {
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
        },
        penalties: {
          only: [:id, :period, :time, :length, :infraction],
          include: {
            player: {
              only: [:id, :name]
            },
            team: {
              only: [:id, :name]
            }
          }
        },
        players: {
          only: [:id, :name, :position, :jersey_num],
          stats: @season
        },
        team: {
          only: [:id, :name]
        },
        season: {
          only: [:id, :name]
        },
        owner: {
          only: [:id]
        }
      },
      methods: [:score]
    }
    @game.to_json(options)
  end

end