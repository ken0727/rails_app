class UserSessionsController < ApplicationController
 

  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      flash[:success] = t(".success")
      redirect_back_or_to root_path
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def destroy
    logout
    flash[:danger] = t(".logout")
    redirect_to root_path
  end
end