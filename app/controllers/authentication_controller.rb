class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  api :POST, '/shops/sign_in'
  api :POST, '/players/sign_in'
  param :email, String, :desc => "Username for login", :required => true
  param :password, String, :desc => "Password for login", :required => true
  description <<-EOS
    == Requêtes
      {
       "email": "toto@titi.com",
       "password": "azertyuiop"
      }

    === Réponse
      {
      "auth_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE0NzQzMTk3ODR9.04CDJyNcU1b7XcJ-wJflDhhEBg9O6HWWi_n5vFFqClA"
      }
  EOS
  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])
    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: "Login invalid" }, status: :unauthorized
    end
  end


  api :POST, '/shops/sign_up'
  api :POST, '/players/sign_up'
  param :email, String, :desc => "Username for login", :required => true
  param :password, String, :desc => "Password for login", :required => true
  description <<-EOS
    == Requêtes
      {
       "email": "toto@titi.com",
       "password": "azertyuiop"
      }

    === Réponse
      {
      "auth_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE0NzQzMTk3ODR9.04CDJyNcU1b7XcJ-wJflDhhEBg9O6HWWi_n5vFFqClA"
      }
  EOS
  def sign_up
    if User.find_by_email(params[:email])
      return render json: { error: "email already taken" }, status: :unauthorized
    end
    # print(isEmail(params[:email]))
    if isEmail(params[:email])
      return render json: { error: "email not valid" }, status: :unauthorized
    end
    if User.create(email: params[:email], password: params[:password], password_confirmation: params[:password])
      command = AuthenticateUser.call(params[:email], params[:password])
      if command.success?
        return render json: { auth_token: command.result }
      else
        return render json: { error: "errors" }, status: :unauthorized
      end
    else
      return render json: {"errors": "dommage"}, status: 422
    end
  end

  private

  def isEmail(str)
    return str.match(/[a-zA-Z0-9._%]@(?:[a-zA-Z0-9]\.)[a-zA-Z]{2,4}/)
  end
end
