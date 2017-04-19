class TargetsController < ApplicationController
  before_action :set_target, only: [:show, :edit, :update, :destroy]

  # GET /targets
  # GET /targets.json
  def index
    @targets = Target.all
  end

  # GET /targets/1
  # GET /targets/1.json
  def show
  end

  # GET /targets/new
  def new
    @target = Target.new
    access_key = '16e5c472cbad4e592e977029af54b1500b551362'
    secret_key = '932998f43862357f0da1a3e9b0340f5b38c55eb1'
    connection = Vws::Api.new(access_key, secret_key)
    width = 32
    active_flag = true
    application_metadata = nil
    puts @target.image.inspect
    puts vuforia_return = "ok"
    vuforia_return = connection.add_target(target_name, "http://api.playarshop.com" + @target.image.url, width, active_flag, application_metadata)
    # vuforia_return = connection.add_target(target_name, "./public/logo.png", width, active_flag, application_metadata)
    puts vuforia_return.inspect
  end

  # GET /targets/1/edit
  def edit
  end

  # POST /targets
  # POST /targets.json
  api :POST, '/targets', "Créer un ou plusieurs cible"
  description <<-EOS
    === Requête
      Doit avoir une image
      {
        "target": [{
            "place": "rennes",
            "city": "RENNES",
            "image": "data:image/png;base64," + logo en hexa
          }, {
            "place": "Germont",
            "city": "RENNES",
            "image": "data:image/png;base64," + target en hexa
          }]
       }
    === Réponse
      Code OK => 201
      {
        "game_ref": "968aff72907b7784d0253b0be5aecc63c8648fca"
      }

  EOS
  error :code => 401, :desc => "Non autorisé"
  error :code => 400, :desc => "Pas d'image"
  def create
    @user = User.find_by(id: current_user.id)
    print @user.inspect
    @company = Company.find_by(user_id: @user.id)
    game_id = Digest::SHA1.hexdigest([Time.now, rand].join)
    targets_params = params.require(:target)
    access_key = '16e5c472cbad4e592e977029af54b1500b551362'
    secret_key = '932998f43862357f0da1a3e9b0340f5b38c55eb1'
    connection = Vws::Api.new(access_key, secret_key)
    width = 32
    active_flag = true
    application_metadata = nil
    targets_params.each do |t|
      @company.targets.create(t.permit(:vuforia_name, :transaction_id, :target_id, :image, :path, :place, :city, :discountChance, :discountRate))
      @target = @company.targets.last
      target_name = Digest::SHA1.hexdigest([Time.now, rand].join)
      if @target.image.url.nil?
        return render json: {"error": "No Image"}, status: 302
      end
      # vuforia_return = connection.add_target(target_name, "http://api.playarshop.com" + @target.image.url, width, active_flag, application_metadata)
      vuforia_return = connection.add_target(target_name, "http://localhost:3000" + @target.image.url, width, active_flag, application_metadata)
      print vuforia_return.inspect
      connection_hash = JSON.parse(vuforia_return)
      @target.vuforia_name = target_name
      @target.transaction_id = game_id
      @target.save
    end
    # @target = Target.new(target)
    puts vuforia_return = "ok"
    # vuforia_return = connection.add_target("target_name", "./public/logo.png", width, active_flag, application_metadata)
    puts vuforia_return.inspect

    # respond_to do |format|
      # if @company.targets.save
        # format.html { redirect_to @target, notice: 'Targetqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq was successfully created.' }
    return render json:{  "game_ref": game_id }, status: 201
      # else
        # format.html { render :new }
        # return render json: { render json: {"target": "errors"}, status: :unprocessable_entity }
        # return render json:{  "status": "created" }, status: 401
      # end11111
    # end
  end

  # PATCH/PUT /targets/1
  # PATCH/PUT /targets/1.json
  def update
    respond_to do |format|
      if @target.update(target_params)
        format.html { redirect_to @target, notice: 'Target was successfully updated.' }
        format.json { render :show, status: :ok, location: @target }
      else
        format.html { render :edit }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /targets/1
  # DELETE /targets/1.json
  def destroy
    @target.destroy
    respond_to do |format|
      format.html { redirect_to targets_url, notice: 'Targetsssssssssssssssssssssssssss was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_target
      access_key = '16e5c472cbad4e592e977029af54b1500b551362'
      secret_key = '932998f43862357f0da1a3e9b0340f5b38c55eb1'
      connection = Vws::Api.new(access_key, secret_key)
      width = 32
      active_flag = true
      application_metadata = nil
      puts @target.image.inspect
      puts vuforia_return = "ok"
      # vuforia_return = connection.add_target(target_name, "http://api.playarshop.com" + @target.image.url, width, active_flag, application_metadata)
      vuforia_return = connection.add_target(target_name, "./public/logo.png", width, active_flag, application_metadata)
      puts vuforia_return.inspect
      @target = Target.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def target_params
      params.require(:target).permit(:vuforia_name, :transaction_id, :target_id, :image, :path, :place, :city, :discountChance, :discountRate)
    end
end
