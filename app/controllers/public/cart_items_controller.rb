class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    # カートに入ってる商品の合計金額
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end
  
  def create
    @cart_item ||= current_cart.cart_items.build(product_id: params[:item_id])
    @cart_item.amount += params[:amount].to_i
    if  @cart_item.save
      flash[:notice] = '商品が追加されました。'
      redirect_to cart_items_path
    else
      flash[:alert] = '商品の追加に失敗しました。'
      redirect_to item_url(params[:item_id])
    end
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
    if @cart_item.destroy
      flash[:notice] = 'カート内の商品が削除されました'
    else
      flash[:alert] = '削除に失敗しました'
    end
    redirect_to cart_items_path
  end
  
  def destroy_all
    CartItems.destroy_all
    redirect_to items_path
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

  def setup_cart_item!
    @cart_item = current_cart.cart_items.find_by(item_id: params[:item_id])
  end
  
end
