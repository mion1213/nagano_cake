class Public::HomesController < ApplicationController
  def top
    @items = Item.page(params[:page]).per(4).order(created_at: :desc)
  end
  
  def about
  end
end
