class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]

  # GET /scores
  api :GET, '/scores', "Application mobile récupère les scores du joueur"
  description <<-EOS

    === Réponse
    {
      "scores": [
        {
          "name": "Ballons ",
          "score": "422",
          "created_at": "2016-07-20T23:27:20.610Z"
        },
        {
          "name": "Ballons ",
          "score": "42",
          "created_at": "2016-07-20T23:48:45.889Z"
        }
      ]
    }
  EOS
  formats ['json']
  param :name, String, :desc => "Nom du jeu", :required => false
  # param :score, String, :desc => "Score du joueur", :required => false
  param :created_at, String, :desc => "Joué le", :required => false
  def index
    @scores = Score.select(:game_id, :created_at, :player_id, :score, :id).where(player_id: @current_user.id)
    puts @scores.inspect
    @games = Game.select(:name).all
    puts @games.inspect
    @finale = Array.new
    @array = []
    @scores.each do |i|
      res = @games.find_by(id: i.game_id)
      if  !res.nil?
        @hash = { :name => res.name, :score => i.score, :created_at => i.created_at }
        @array.push(@hash)
      end
    end
    tmp = @array.sort_by { | obj | obj[:created_at]}
    @array = tmp
  end

  api :POST, '/scores', "Application mobile envoie le score"
  description <<-EOS

    === Infos
      Si jamais le score est supérieur à la limite à battre, alors le joueur obtiendra une réduction
      code 200 => OK
    === Requête
      {
          "game_id": "1",
          "target_id": "1",
          "score": "120"
      }
    === Réponse
      {
          "reduction": "t’as gagné 2%"
      }
  EOS
  formats ['json']
  param :game_id, String, :desc => "id du jeu persionnalisé", :required => false
  param :target_id, String, :desc => "id du jeu persionnalisé", :required => false
  param :reduction, String, :desc => "Réduction à afficher", :required => false
  def create
    @game = Game.find_by(id: score_params[:game_id])
    @discount = Discount.find_by(game_ref: @game.perso1)
    @game = Game.find_by(id: params[:game_id])
    if @discount.nil?
      return render json: {error: "not found"}, status: 404
    end
    @score = Score.new(score_params)
    @score.player_id = @current_user.id

    @game_list = GameList.find_by(id: @game.ref)
    score = score_params[:score]
    puts @game_list.inspect
    if score.to_i > @game_list.level[0].to_i
      @score.location_gps = "win"
      @score.save
      return render json: {reduction: @discount.success}, status: 200
    else
      @score.location_gps = "fail"
      @score.save
      return render json: {reduction: @discount.fail}, status: 200
    end
  end

  api :GET, '/stats_games', "Commercants Front - end : recoit les stats du nombre de jeu joué par jeux"
  description <<-EOS
    == Param 
      name : nom du jeu
      nb : nombre de fois que le jeu a été joué
    === Réponse
      {
        "donut": [
          {
            "name": "Name 1",
            "nb": 2
          },
          {
            "name": "Name 1",
            "nb": 3
          },
          {
            "name": "Name 1",
            "nb": 1
          }
        ]
      }
  EOS
  formats ['json']
  param :donut, String, :desc => "Nombre de jeux joués par réductions", :required => false 
  def stats_games
     @company = Company.find_by(user_id:  @current_user.id)
     @tab = []
     @company.games.each do | c |
       @scores = Score.where(game_id: c.id)
       @tab.push(name: c.name, nb: @scores.size)
     end
  end

  api :GET, '/stats', "Commercants Front - end : recoit les stats"
  description <<-EOS
    === Réponse
      {
        "linechart": [
          {
            "date": "2016-07-31",
            "nb": 0
          },
          {
            "date": "2016-08-31",
            "nb": 0
          },
          {
            "date": "2016-09-30",
            "nb": 0
          },
          {
            "date": "2016-10-31",
            "nb": 0
          },
          {
            "date": "2016-11-30",
            "nb": 0
          },
          {
            "date": "2016-12-31",
            "nb": 2
          },
          {
            "date": "2017-01-31",
            "nb": 13
          }
        ]
      }
  EOS
  formats ['json']
  param :linechart, String, :desc => "Nombre de jeux joués par mois", :required => false
  param :donut, String, :desc => "Nombre de jeux joués par réductions", :required => false
  def stats
    @company = Company.find_by(user_id:  @current_user.id)
    if @company.nil?
      return render json: {errors: "No company"}, status: 200
    end
    @month = Array.new(7)
    @score = Score.all
    t = Date.today
    t_min = Date.today - 6.month
    t_min = Time.new(t_min.year,t_min.month,1).to_date
    print t
    print t_min
    i = 0
    @linechart = []
    for i in 0..6
      t_tmp = Date.new(t_min.year, t_min.month, -1)
      @linechart.push(date: t_tmp, nb: @score.where(created_at: t_min..t_tmp).size)
      t_min = t_min + 1.month
    end
    @discount = Discount.all.where(company_id: @company.id).size
    print @discount.inspect
     @tab = []
     @company.games.each do | c |
       @scores = Score.where(game_id: c.id)
       @tab.push(name: c.name, nb: @scores.size)
     end
     return render :json => {
      :linechart => @linechart.as_json(),
      :tab => @tab.as_json()
    }, status: 200
  end

  # DELETE /scores/1
  def destroy
    @score.destroy
    respond_to do |format|
      format.html { redirect_to scores_url, notice: 'Score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_score
      @score = Score.find(params[:id])
    end
    def score_params
      params.permit(:target_id, :player_id, :game_id, :success, :score, :lieu, :location_gps)
    end
end
