class BoardsController < ApplicationController
  def index
    # ログインしていない場合はログイン画面にリダイレクト
    if logged_in? == false
      redirect_to login_path
      flash[:danger] = t('views.boards.index.login') # ログインしてください
    end
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      flash[:success] = t('views.boards.create.success') # 掲示板を作成しました
      redirect_to boards_path
    else
      flash.now[:danger] = t('views.boards.create.fail') # 掲示板を作成できませんでした
      render :new
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image)
  end
end


