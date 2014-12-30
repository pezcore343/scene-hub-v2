class BandsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def show
    @band = Band.find(params[:id])
    @band_post = BandPost.new
    @genre_list = GenreList.find_by(band_id: @band.id)
  end

  def new
    @band = Band.new
    @genre_list = GenreList.new
  end

  def create
    @user = User.find(current_user.id)
    @band = Band.create(band_params)
    if @band.save
      @genres = GenreList.create(genre_list_params)
      flash[:notice] = "Band created!"
      redirect_to band_path(@band)
    else
      render "new"
    end
  end

  private

  def band_params
    band_params = params.require(:band).permit(:name)
    band_params[:user_id] = current_user.id
    band_params
  end

  def genre_list_params
    genres = params.require(:genre_list)[:genres].split(", ")
    genre_params = Hash.new
    genre_params[:genres] = genres
    genre_params[:band_id] = @band.id
    genre_params
  end
end
