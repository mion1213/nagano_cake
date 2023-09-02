class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def confirm
  end
  
  def complete
  end
  
  def create
  end
  
  def index
    @orders = Orders.all
  end
  
  def show
    @order = Order.find(params[:id])
  end
end
