class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @user = User.find(current_user.id)
    @companies = Company.find_by(user_id: @user.id)
    print @companies.inspect
    if !@companies.nil?
      return render json: @companies
    else
      return render json:{  "error": "No company" }, status: 200
    end
  end

  api :GET, '/companies/all', "Récupérer les lieux de jeu"
  description <<-EOS
    === Requête
      {
          {
            "spots": [
                {
                    "name": "Epitech",
                    "location": "Paris",
                    "description": "Ecole pour l'informatique",
                    "adress": "65, rue Parmentier, 75004",
                    "phone": "+33 7 56 78 65 34"
                },
                {
                    "name": "Wargame",
                    "location": "Rennes",
                    "description": "Bornes de jeux",
                    "adress": "22, rue de la mairie, 34500",
                    "phone": "+33 3 90 98 56 54"
                }
            ]
        }
      }
    === Réponse
      Code OK => 201
  EOS
  error :code => 401, :desc => "Non autorisé"
  def all
      @companies = Company.all
  end

  def payment
    @amount = 500

    customer = Stripe::Customer.create(
       :email => params[:stripeEmail],
       :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
  end

  api :POST, '/companies', "Créer une company"
  description <<-EOS
    === Requête
      {
        "company": {
            "name": "playarshop",
            "logo": "data:image/png;base64," + logo
          }
      }
    === Réponse
      Code OK => 201
  EOS
  error :code => 401, :desc => "Non autorisé"
  def create
      @user = User.find(current_user.id)
      @user.company.create(company_params)
      return render json:{  "Status": "Company created" }, status: 201
  end

    api :GET, '/location', "Récupérer les entrerprises et lieux de jeux"
    description <<-EOS
      === Réponse
        Headers : Location: url du jeu
        Code : 200 si OK
        Body :
              {
                "company": [
                  {
                    "name": "Company 1",
                    "location": null,
                    "lat": "2",
                    "lng": "4",
                    "logo": null,
                    "target": [
                      {
                        "id": 2,
                        "vuforia_name": "",
                        "transaction_id": "",
                        "target_id": null,
                        "image": {
                          "url": null
                        },
                        "path": "",
                        "place": "",
                        "city": "Paris",
                        "discountChance": "",
                        "discountRate": "",
                        "company_id": 1,
                        "game_id": null,
                        "created_at": "2017-01-03T20:17:42.242Z",
                        "updated_at": "2017-01-03T20:17:44.073Z"
                      },
                      {
                        "id": 1,
                        "vuforia_name": "",
                        "transaction_id": "",
                        "target_id": null,
                        "image": {
                          "url": null
                        },
                        "path": "",
                        "place": "Comptoir de Mac Do",
                        "city": "Rennes",
                        "discountChance": "",
                        "discountRate": "",
                        "company_id": 1,
                        "game_id": null,
                        "created_at": "2017-01-03T20:17:31.755Z",
                        "updated_at": "2017-01-03T20:17:44.067Z"
                      }
                    ]
                  }
                ]
              }
    EOS
  def location
    @user = User.find(current_user.id)
    @target = @user.company
  end



  api :GET, '/companies', "Récupérer l'entreprise, le logo"
  description <<-EOS
    === Réponse
      {
          "name": "name",
          "logo": "url de l'image",
          "siret": "siret"
      }
  EOS
  error :code => 401, :desc => "Non autorisé"
  param :name, String, :desc => "Nom du jeu", :required => true
  def show
    @company = Company.find_by(id: company_params[:id])
    @base64 = @company.logo.url
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end


  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def recap
    puts @current_user.inspect
    @shop = Shop.find_by(id: @current_user.user_type_id)
    @company = Company.find_by(id: @shop.company_id)
    puts @company.inspect
    @target = @company.targets.last
    puts @target.inspect
    @game = Game.find_by(id: @company.games.last.id)
    @discount = Discount.find_by(id: @company.discounts.last.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end
    def discount_params
      params.require(:discount).permit(:success, :fail)
    end

    def target_params
      params.require(:target).permit(:place, :image, :city)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def game_params
      # params.require(:game).permit(:ref, :name, :description, :logo, :color1, :color2, :perso1, :perso2, :custom, :discount, :vuforia_name)
    # end
    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :logo, :siret)
    end
end
