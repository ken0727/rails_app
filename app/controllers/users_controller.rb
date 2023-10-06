class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t('views.users.create.success')
      redirect_to login_path
    else
      flash.now[:danger] = t('views.users.create.fail')
      render :new
    end
  end

    def bookmarks
    @bookmarked_boards = current_user.bookmarked_boards
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :last_name, :first_name)
  end
end