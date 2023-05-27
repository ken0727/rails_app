class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user) # ユーザー作成
      redirect_to login_path
    else
      render 'new' # ユーザー作成に失敗した場合は、新規登録画面を再表示する
    end
  end

  private

  def user_params
  params.require(:user).permit(:last_name, :first_name, :email, :password)
  end

end
