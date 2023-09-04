class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
  end
  
  def create
    @address = Addres.new(address_params)
    @address.save
    redirect_to :index
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to :index
  end
  
  def destroy
    address = Address.find(params[:id])
    address.delete
    redirect_to :index
  end
  
  private
  
  def address_params
    params.require(:address).permit(:name, :address, :postal_code)
  end
end
