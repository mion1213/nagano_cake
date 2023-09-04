class Admin::OrdersController < ApplicationController
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    flash[:notice] = 'ステータスを更新しました'
    redirect_to admin_order_path(@order)
  end
  
  def show
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
  
end
