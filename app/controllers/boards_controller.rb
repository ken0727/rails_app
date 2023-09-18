class BoardsController < ApplicationController
  def index
    # ログインしていない場合はログイン画面にリダイレクト
    redirect_to login_path unless logged_in?
    @boards = Board.all
  end
end