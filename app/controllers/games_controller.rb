class GamesController < ApplicationController
  before_action :set_game, only: %i[show update]
  def new
    @game = Game.new
  end

  def index
  # @games = if params[:view_all]
  #   Game.all.order(created_at: :desc)
  # else
  #   Game.order(created_at: :desc)
  # end

    @games = Games::Index.call(
      filter_params: params[:filter] || {},
      page: params[:page]
    )
  end

  def show
    @board = JSON.parse(@game.board)
    @revealed = JSON.parse(@game.revealed)
  end

  def create
    @game = Game.new(permitted_create_params)
    if @game.save
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def update
    row = params[:row].to_i
    col = params[:col].to_i

    @game = Games::RevealCell.call(@game, row, col)
    redirect_to game_path(@game)
  end

  private

  def permitted_create_params
    params.require(:game).permit(
      :name, :email, :width, :height, :number_of_mines
    )
  end

  def set_game
    @game = Game.find(params[:id])
  end
end
