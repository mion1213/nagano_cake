class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_user.id)
  end
  
  def edit
  end
  
  def update
  end
  
  def check
  end
  
  def withdraw
  end
end
