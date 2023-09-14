class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
  end
  
  def edit
    @customer = Customer.find(current_customer.id)
  end
  
  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      flash[:notice] = "更新に成功しました"
      redirect_to public_customers_profile_path
    else
      flash[:notice] = "更新に失敗しました"
      render :edit
    end
  end
  
  def check
    @customer = Customer.find(current_customer.id)
  end
  
  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    # reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :last_name_kana, :first_name, :first_name_kana,
    :postal_code, :address, :telephone_number, :is_deleted)
  end
end
