class PlayerCodeSerializer

  def initialize(player_code_obj)
    @player_code = player_code_obj
  end

  def create_to_serialized_json
    options = {
      only: [:code]
    }
    @player_code.to_json(options)
  end

  def show_to_serialized_json
    options = {
      only: [:code],
      include: {
        player: {
          only: [:id, :name]
        },
        team: {
          only: [:id, :name],
          include: {
            owner: {
              only: [:id, :name]
            }
          }
        }
      }
    }
    @player_code.to_json(options)
  end

end