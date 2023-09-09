class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: %i[increase decrease destroy]
  
  def index
    @cart_items = current_customer.cart_items
    # カートに入ってる商品の合計金額
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end
  
  def create
    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item
      @cart_item.update(amount: @cart_item.amount + params[:cart_item][:amount].to_i)
    else
      CartItem.create(item_id: params[:cart_item][:item_id], amount: params[:amount].to_i, customer_id: current_customer.id)
      flash[:notice] = '商品が追加されました。'
    end
    redirect_to cart_items_path
  end
  
  def update
    if @cart_item.update(amount: params[:amount].to_i)
      flash[:notice] = 'カートが更新されました'
    else
      flash[:alert] = 'カートの更新に失敗しました'
    end
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
