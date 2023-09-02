class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find([:id])
  end
  
  def edit
    @customer = Customer.find([:id])
  end
  
  def update
    @customer = Customer.find([:id])
    @customer.update(customer_params)
    redirect_to :index
  end
  
  def customer_params
    params.require(:customer).permit(:last_name, :last_name_kana, :first_name, :first_name_kana,
    :postal_code, :address, :telephone_number,)
  end
end
