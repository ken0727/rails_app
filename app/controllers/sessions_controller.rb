class SessionsController < ApplicationController
    
    def new
    end

  
  def create
  user = login(params[:email], params[:password])
  if user
    redirect_to root_path, notice: "ログインしました。"
  else
    flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません。" if params[:email].present? && params[:password].present?
    render :new
  end
end

  

  def destroy
    logout # セッションを破棄する
    redirect_to root_path, notice: "ログアウトしました。"
  end
end
