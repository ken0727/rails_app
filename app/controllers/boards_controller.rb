class BoardsController < ApplicationController
  def index
    # ログインしていない場合はログイン画面にリダイレクト
    unless logged_in?
      redirect_to login_path
      flash[:danger] = "ログインしてください"
    end
    @boards = Board.all
  end
end