class SubsController < ApplicationController
  before_action :force_login
  before_action :not_the_mod, only: :edit

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end

  def edit

  end

  def show
    @sub = Sub.find_by(params[:id])
    render json: @sub
  end

  private

  def force_login
    redirect_to new_session_url if current_user.nil?
  end

  def not_the_mod
    @sub = Sub.new(sub_params)
    unless @sub.moderator == current_user
      current_user[:errors] << "Must be the moderator to edit this session"
    end
  end

  def sub_params
    params.require(:sub).permit(:description, :title)
  end

end
