class UserSerializer

  def initialize(user)
    @user = user
  end

  def to_serialized_json
    options = {
      only: [:id, :username, :name]
    }
    @user.to_json(options)
  end

end