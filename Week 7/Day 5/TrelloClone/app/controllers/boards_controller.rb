class BoardsController < ApplicationController
  def index
    render json: Board.all
  end

  def show
    board = Board.find(params[:id])
    if board
      render json: board, include: :lists
    else
      render status: 404
    end
  end

  def create
    board = Board.new(board_params)
    if board.save
      render json: board
    else
      render json: board.errors.full_messages, status: 422
    end
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy!
  end

  private
  def board_params
    params.require(:board).permit(:title)
  end
end
