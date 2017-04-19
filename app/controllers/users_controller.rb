class UsersController < ApplicationController
  api :GET, '/users', "Récupérer information du User"
  description <<-EOS
    === Réponse
      {
          "name": "newName",
          "email: "newEmail"
      }
  EOS
  error :code => 401, :desc => "Non autorisé"
  param :name, String, :desc => "Nom du jeu", :required => false
  def index
    @user = User.select(:email, :name, :user_name, :first_name, :last_name, :adress, :image, :function, :about).find(current_user.id)
  end

  api :POST, '/users', "Changer information du User"
  description <<-EOS
    === Request
      {
          "name": "newName",
          "email: "newEmail"
      }
    === Réponse
      {
          "name": "newName",
          "email: "newEmail"
      }
  EOS
  error :code => 401, :desc => "Non autorisé"
  param :name, String, :desc => "Nom du jeu", :required => false
  def create
    @user = User.find(current_user.id)
    @user.update_attributes(user_params)
    render json: @user
  end

  api :POST, '/email', "Envoi Email"
  description <<-EOS
    === Request
      {
        "email": "vincent.galoger@gmail.com"
      }
    === Réponse
    {
      "password_digest": "$2a$10$Jcdq4QQuCjGC5OMeh0fyAultM1TWlylfeetOv.q/nrNAj4AXO04/W",
      "id": 2,
      "image": {
        "url": null
      },
      "name": null,
      "email": "vincent.galoger@gmail.com",
      "company_name": "",
      "user_name": "",
      "first_name": "",
      "last_name": "",
      "address": "",
      "token": "",
      "phone": "",
      "function": "",
      "about": "",
      "created_at": "2016-12-13T19:48:59.309Z",
      "updated_at": "2016-12-13T19:49:21.772Z"
      }
  EOS
  error :code => 401, :desc => "Non autorisé"
  param :name, String, :desc => "Nom du jeu", :required => false
  def email
    print user_params[:email]
    @user = User.find_by(email: user_params[:email])
    if @user.nil?
      return render :json => {error: "Mail non trouvé"}, :status => 404
    end
    @user.password = Digest::SHA1.hexdigest([Time.now, rand].join)
    @user.password = @user.password.slice(0,8)
    @user.update_attributes(password: @user.password)
    UserEmailerMailer.welcome_email(@user).deliver_now
    render json: @user
  end

  def user_params
    params.permit(:email, :name, :password, :user_name, :first_name, :last_name, :adress, :image, :token, :function, :about)
  end
end
