class Admin::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルが追加されました"
      redirect_to admin_genres_path
    else
      flash[:notice] = "ジャンルの追加に失敗しました"
      @genres = Genre.all
      render :index
    end
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    # @genres = Genres.all
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "更新に成功しました"
      redirect_to admin_genres_path
    else
      render :edit
    end
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
  
end
