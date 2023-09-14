class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
  end
  
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice] = "配送先を追加しました"
      redirect_to addresses_path
    else
      @addresses = Address.all
      render :index
    end
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
  end
  
  def destroy
    address = Address.find(params[:id])
    address.delete
    redirect_to addresses_path
  end
  
  private
  
  def address_params
    params.require(:address).permit(:name, :address, :postal_code, :customer_id)
  end
end
