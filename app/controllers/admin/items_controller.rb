class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "商品が追加されました"
      redirect_to admin_item_path(@item.id)
    else
      flash[:notice] = "商品の追加に失敗しました"
      render :new
      # バリデーションエラーを確認
      puts @item.errors.full_messages
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_item =CartItem
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "更新に成功しました"
      redirect_to admin_item_path(@item.id)
    else
      flash[:notice] = "更新に失敗しました"
      render admin_item_path(@item.id)
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image, :is_active, :genre_id)
  end
end
