class AlbumsController < ApplicationController
  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
  end

  private
  def album_params
    params.require(:album).permit(:title, :style)
  end
end
