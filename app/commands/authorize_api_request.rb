class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(token = nil)
    puts 'token?'
    puts token
    @token = token
  end

  def call
    user
  end

  private

  attr_reader :token

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    puts @token
    puts JsonWebToken.decode(@token)
    @decoded_auth_token ||= JsonWebToken.decode(token)
    puts @decoded_auth_token
    @decoded_auth_token
  end

end