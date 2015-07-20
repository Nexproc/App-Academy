class BandsController < ApplicationController
  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def delete
    #deletes band
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    band = Band.new(params[:band][:name])
    if band.save
      redirect_to bands_url
    else
      flash[:errors] << band.errors.full_messages
      render :new
    end
  end
end
