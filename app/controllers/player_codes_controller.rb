class PlayerCodesController < ApplicationController

  def create
    player = Player.find_by(id: params[:player_id])
    if exists_and_owner?(player)
      player_code = PlayerCode.new(player: player)
      if player_code.save
        render json: PlayerCodeSerializer.new(player_code).create_to_serialized_json
      else
        render json: { error: player_code.errors.full_messages }, status: :bad_request
      end
    end
  end

  def show
    if set_code_and_checks
      render json: PlayerCodeSerializer.new(@player_code).show_to_serialized_json
    end
  end

  def link
    byebug
    if set_code_and_checks
      player = @player_code.player
      player.user = @current_user
      if player.save
        @player_code.destroy
        render json: { message: "User Linked!"}
      else
        render json: { error: player.errors.full_messages }, status: :bad_request
      end
    end
  end

  private

  def set_code_and_checks
    @player_code = PlayerCode.find_by(code: params[:code])
    if @player_code
      if !@player_code.team.users.include?(@current_user)
        return true
      else
        render json: { error: "You're already on that team" }, status: :bad_request and return
      end
    else
      render json: { error: "Code not found" }, status: :bad_request and return
    end
  end

end