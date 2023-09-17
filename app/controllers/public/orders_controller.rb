class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  # 注文情報入力画面
  def new
    @order = Order.new
    @address = Address.new 
    @addresses = current_customer.addresses.all
  end

  # 注文情報入力確認画面
  def confirm
    @order_items = current_customer.cart_items
    select_address = params[:order][:select_address].to_i
    if select_address == 0
      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif select_address == 1
      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif select_address == 2
      @order = Order.new(order_params)
    else
      render :new
    end
  end

  # 注文情報保存
  def create
    @order = current_customer.orders.build(order_params)
    
    
    if @order.save
      current_customer.cart_items.each do |cart_item|
        ordered_item = @order.ordered_items.build(
          item_id: cart_item.item_id,
          amount: cart_item.amount,
          tax_included_price: cart_item.item.with_tax_price
        )
        ordered_item.save
      end

      current_customer.cart_items.destroy_all
      redirect_to complete_orders_path
    else
      render 'new'
    end
  end

  # 注文完了画面
  def complete
  end

  # 注文情報履歴一覧
  def index
    @orders = current_customer.orders
  end

  # 注文情報詳細
  def show
    @order = current_customer.orders.find(params[:id])
    @items = @order.items
  end

  private

  def order_params
    params.require(:order).permit(:postage, :payment_method, :billing_amount, :address, :postal_code, :name, :status, :customer_id)
  end
end
