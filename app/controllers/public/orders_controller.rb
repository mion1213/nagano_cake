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
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @postage = 800
    @total = @cart_items.sum { |item| item.subtotal.to_i }
    @billing_amount = @postage + @total
    @select_payment_method = params[:order][:payment_method]
    
    @order_items = current_customer.cart_items
    select_address = params[:order][:select_address]
    if select_address == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif select_address == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif select_address == "2"
      @order_new = Order.new
      @address = Address.new
    else
      render :new
    end
  end

  # 注文情報保存
  def create
    @order = current_customer.orders.build(order_params)
    
    
    if @order.save
      current_customer.cart_items.each do |cart_item|
        order_detail = @order.order_details.build(
          item_id: cart_item.item_id,
          quantity: cart_item.amount,
          price_including_tax: cart_item.item.with_tax_price
        )
        order_detail.save
      end

      current_customer.cart_items.destroy_all
      redirect_to complete_orders_path
    else
      render :new
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
    @order_details = @order.order_details
  end

  private

  def order_params
    params.require(:order).permit(:postage, :payment_method, :billing_amount, :address, :postal_code, :name, :status, :customer_id)
  end
end
