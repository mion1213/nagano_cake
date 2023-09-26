class Admin::OrdersController < ApplicationController
  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_params)
      @order_details.update_all(crafting_status: 1) if @order.status == "payment_confirmation"
    ## ①注文ステータスが「入金確認」のとき、製作ステータスを全て「製作待ち」に更新する
    end
    flash[:notice] = 'ステータスを更新しました'
    redirect_to admin_order_path(@order)
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.all
    @order_detail = OrderDetail.find(params[:id])
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
  
end
