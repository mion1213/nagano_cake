class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.delete
    redirect_to :index
  end
  
  def destroy_all
    cart_items = CartItems.all
    cart_items.delete
    redirect_to items_path
  end
end
