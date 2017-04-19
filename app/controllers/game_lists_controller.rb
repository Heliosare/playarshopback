class GameListsController < ApplicationController
  before_action :set_game_list, only: [:show, :edit, :update, :destroy]

  # GET /game_lists
  # GET /game_lists.json
  def index
    @game_lists = GameList.all
  end

  # GET /game_lists/1
  # GET /game_lists/1.json
  def show
  end


  # GET /game_lists/new
  def new
    @game_list = GameList.new
  end

  # GET /game_lists/1/edit
  def edit
  end

  # POST /game_lists
  # POST /game_lists.json
  def create
    @game_list = GameList.new(game_list_params)

    respond_to do |format|
      if @game_list.save
        format.html { redirect_to @game_list, notice: 'Game list was successfully created.' }
        format.json { render :show, status: :created, location: @game_list }
      else
        format.html { render :new }
        format.json { render json: @game_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_lists/1
  # PATCH/PUT /game_lists/1.json
  def update
    respond_to do |format|
      if @game_list.update(game_list_params)
        format.html { redirect_to @game_list, notice: 'Game list was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_list }
      else
        format.html { render :edit }
        format.json { render json: @game_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_lists/1
  # DELETE /game_lists/1.json
  def destroy
    @game_list.destroy
    respond_to do |format|
      format.html { redirect_to game_lists_url, notice: 'Game list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_list
      @game_list = GameList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_list_params
      params.require(:game_list).permit(:name, :description, :image, :level)
    end
end
