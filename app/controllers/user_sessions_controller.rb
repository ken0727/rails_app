class UserSessionsController < ApplicationController
 

  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      flash[:success] = t('views.user_sessions.create.success')
      redirect_back_or_to boards_path
    else
      flash.now[:danger] = t('views.user_sessions.create.fail')
      render :new
    end
  end

  def destroy
    logout
    flash[:danger] = t('views.user_sessions.destroy.success')
    redirect_to root_path
  end
end