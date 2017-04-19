class ApplicationController < ActionController::Base
  before_action :authenticate_request, except: [:email]
  attr_reader :current_user
  before_action :set_default_response_format


  private

  def set_default_response_format
    request.format = :json
  end

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless params[:controller] == "rails_admin/main" || @current_user
  end
end
