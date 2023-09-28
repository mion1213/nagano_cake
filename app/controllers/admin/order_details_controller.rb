class Admin::OrderDetailsController < ApplicationController
  def update
  # 注文詳細データを取得
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order

  # 製作ステータスを更新
    @order_detail.update(order_detail_params)
    
      # 注文に紐づくすべての注文詳細の製作ステータスが「製作完了」だったら
      if @order.order_details.all? { |order_detail| order_detail.crafting_status == "production_complete" }
        # 注文の注文ステータスを「発送準備中」に更新
        @order.update(status: 3)
      elsif @order_detail.crafting_status == "in_production"
        # 注文詳細の製作ステータスが「製作中」の場合、注文のステータスを「製作中」に更新
        @order.update(status: 2)
      end

    flash[:notice] = 'ステータスを更新しました'
    redirect_to admin_order_path(@order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:crafting_status)
  end
end
