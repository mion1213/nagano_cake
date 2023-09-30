class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :setup_cart_item!, only: %i[increase decrease destroy]
  
  def index
    @cart_items = current_customer.cart_items
    # カートに入ってる商品の合計金額
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @cart_items_count = @cart_items.count
  end
  
  def create
  # 1. 追加した商品がカート内に存在するかの判別
    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])

    if @cart_item
    # 2. カート内の個数をフォームから送られた個数分追加する
      @cart_item.update(amount: @cart_item.amount + params[:cart_item][:amount].to_i)
    else
    # 3. 存在しなかった場合、新しいカートアイテムを作成する
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      @cart_item.save
    end

    flash[:notice] = '商品が追加されました。'
    redirect_to cart_items_path
  end
  
  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.update(amount: params[:amount].to_i)
    flash[:notice] = 'カートが更新されました'
    redirect_to cart_items_path
  end
  
  def destroy
    if @cart_item&.destroy
      flash[:notice] = 'カート内の商品が削除されました'
    else
      flash[:alert] = '削除に失敗しました'
    end
    redirect_to cart_items_path
  end
  
  def destroy_all
    CartItem.destroy_all
    redirect_to items_path
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

  def setup_cart_item!
    @cart_item = current_customer.cart_items.find(params[:id])
  end
  
end
