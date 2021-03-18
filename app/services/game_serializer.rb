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

  def next_game_as_json
    options = {
      only: [:id, :datetime, :opponent, :place]
    }
    @game.as_json(options)
  end

  def last_game_as_json
    options = {
      only: [:id, :datetime, :opponent, :place],
      methods: [:score]
    }
    @game.as_json(options)
  end

  def show_to_serialized_json
    options = {
      only: [:id, :datetime, :opponent, :status, :place],
      include: {
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