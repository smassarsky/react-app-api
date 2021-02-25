class AuthenticateUser
  prepend SimpleCommand

  def initialize(username, password)
    @username = username
    @password = password
  end

  def call
    @user = user
    if @user
      return {user: @user, token: JsonWebToken.encode(user_id: @user.id)}
    else
      return nil
    end
  end

  private

  attr_accessor :username, :password

  def user
    user = User.find_by_username(username)
    return user if user && user.authenticate(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end