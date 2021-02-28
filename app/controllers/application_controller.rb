class ApplicationController < ActionController::API
  include ::ActionController::Cookies

  before_action :authenticate_request
  before_action :snake_case_params
  attr_reader :current_user

  private

  def authenticate_request
    jwt = cookies.signed[:jwt]
    @current_user = AuthorizeApiRequest.call(jwt).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def owner?(thing)
    @current_user == thing.owner
  end

  def exists_and_owner?(thing)
    if thing && owner?(thing)
      true
    elsif thing
      render json: { error: "Not Authorized" }, status: 403
      return false
    else
      render json: { error: "Not Found" }, status: 404
      return false
    end
  end

  def exists_and_teammate?(team)
    if team && team.users.include?(@current_user)
      return true
    elsif team
      render json: { error: "Not Authorized"}, status: 403
      return false
    else
      render json: { error: "Not Found" }, status: 404
      return false
    end

  end

  def snake_case_params
    request.parameters.deep_transform_keys!(&:underscore)
  end

end