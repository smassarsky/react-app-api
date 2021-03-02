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

end