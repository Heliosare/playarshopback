class DiscountsController < ApplicationController
  before_action :set_discount, only: [:show, :edit, :update, :destroy]

  # GET /discounts
  # GET /discounts.json
  # def index
  #   @discounts = Discount.all
  # end
  api :GET, '/discounts', "Application mobile récupère les scores"
  description <<-EOS
    === Réponse
      {
        "discount": [
          {
            "name": "playarshop",
            "success": "Vous avez gagné 42% de réduction",
            "created_at": "2016-07-20T23:27:20.610Z"
          },
          {
            "name": "playarshop",
            "success": "Vous avez gagné 42% de réduction",
            "created_at": "2016-07-20T23:48:29.492Z"
          },
          {
            "name": "playarshop",
            "success": "Vous avez gagné 42% de réduction",
            "created_at": "2016-07-20T23:48:45.889Z"
          }
        ]
      }
  EOS
  formats ['json']
  param :game_id, String, :desc => "id du jeu persionnalisé", :required => false
  param :score, String, :desc => "Score effectué", :required => false
  param :reduction, String, :desc => "Réduction à afficher", :required => false
  def index
    puts current_user.id
    @scores = Score.all.where(player_id: current_user.id)
    puts Score.all.inspect
    @discount = Discount.all
    puts @discount.inspect
    @finale = Array.new
    @array = []
    @scores.each do |i|
      game = Game.find_by(id: i.game_id)
      res = @discount.find_by(game_ref: game.perso1)
      if i.location_gps == "win"
        if  !res.nil?
          name = Company.find_by(id: res.company_id)
          @hash = { :name => name.name, :success => res.success, :created_at => i.created_at }
          @array.push(@hash)
        end
      end
    end
    render "index.json.jbuilder"
  end
  # GET /discounts/1
  # GET /discounts/1.json
  def show
  end

  # GET /discounts/new
  def new
    @discount = Discount.new
  end

  # GET /discounts/1/edit
  def edit
  end

  api :POST, '/discounts', "Créer un ou plusieurs réductions"
  description <<-EOS
    === Requête
      Doit avoir une image
      Doit avoir le meme nombre de personnlisation que le nombre de Target
      {
        "game_ref": "968aff72907b7784d0253b0be5aecc63c8648fca",
        "discount": [{
          "success": "Trouves la licorne",
          "fail": "Trouves la licorne quand même"
        },{
          "success": "Bien joué tu l'as trouvé",
          "fail": "Tu l'as quand même trouvé"
        }]
      }
    === Réponse
      code 201 OK
  EOS
  error :code => 401, :desc => "Non autorisé"
  error :code => 422, :desc => "Pas de company"
  param :game_ref, String, :desc => "Référence du jeu à personnaliser", :required => true
  param :discount, Array, :desc => "Personnlisation du jeu", :required => true
  def create
    @user = User.find_by(id: current_user.id)
    @company = Company.find_by(user_id: current_user.id)
    game_ref = params.require(:game_ref)
    if @company.nil?
      return render :json =>{ "error": "no company"}, status: 422
    end
    game_ref = params.require(:game_ref)
    discounts = params.require(:discount)
    discounts.each do |d|
      @company.discounts.create(d.permit(:level, :success, :fail, :state))
      @discount = @company.discounts.last
      @discount.game_ref = game_ref
      @discount.save
    end
    return render json: {"success": "success"}, status: 201
  end

  # PATCH/PUT /discounts/1
  # PATCH/PUT /discounts/1.json
  def update
    respond_to do |format|
      if @discount.update(discount_params)
        format.html { redirect_to @discount, notice: 'Discount was successfully updated.' }
        format.json { render :show, status: :ok, location: @discount }
      else
        format.html { render :edit }
        format.json { render json: @discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discounts/1
  # DELETE /discounts/1.json
  def destroy
    @discount.destroy
    respond_to do |format|
      format.html { redirect_to discounts_url, notice: 'Discount was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_discount
      @discount = Discount.find(params[:id])
    end

    def discount_params
      params.require(:discount).permit(:level, :success, :fail, :state)
    end
end
