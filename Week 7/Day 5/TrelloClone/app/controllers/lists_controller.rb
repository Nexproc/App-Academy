class ListsController < ApplicationController
  def index
    board = Board.find(params[:board_id])
    render json: board.lists
  end

  def show
    list = List.find(params[:id])
    if list
      render json: list, include: :cards
    else
      render status: 404
    end
  end

  def create
    list = List.new(list_params)
    if list.save
      render json: list
    else
      render json: list.errors.full_messages, status: 422
    end
  end

  def destroy
    list = List.find(params[:id])
    list.destroy!
  end

  private
  def list_params
    params.require(:list).permit(:title, :board_id)
  end
end
