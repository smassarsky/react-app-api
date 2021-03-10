class GameSerializer

  def initialize(game_obj, user_obj=nil)
    @game = game_obj
    @user = user_obj
  end

  def to_serialized_json
    options = {
      only: [:id, :datetime, :opponent, :status, :place],
      methods: [:score]
    }
    @game.to_json(options)
  end

  def show_to_serialized_json
    puts @game
    puts @user
    options = {
      only: [:id, :datetime, :opponent, :status, :place],
      include: {
        goals: {
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
        team: {
          only: [:id, :name],
          methods: [:roster]
        },
        season: {
          only: [:id, :name]
        },
        owner: {
          only: [:id]
        }
      },
      methods: [:score, :events, :players_list],
      users_player: @user
    }
    @game.to_json(options)
  end

end