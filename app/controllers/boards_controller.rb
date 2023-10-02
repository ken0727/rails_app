class BoardsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  before_action :find_board, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
    @button_label = t('views.boards.new.create_button')
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      flash[:success] = t('views.boards.create.success')
      redirect_to boards_path
    else
      flash.now[:danger] = t('views.boards.create.fail')
      render :new
    end
  end

  def show
    @comments = @board.comments.order(created_at: :desc)
    @user = @board.user
  end

  def edit
    @button_label = t('views.boards.edit.update_button')
  end

  def update
    if @board.update(board_params)
      flash[:success] = t('views.boards.update.success')
      redirect_to board_path(@board)
    else
      flash.now[:danger] = t('views.boards.update.fail')
      render :edit
    end
  end

  def destroy
    if @board.destroy
      flash[:success] = t('views.boards.destroy.success')
    else
      flash[:error] = t('views.boards.destroy.fail')
    end
    redirect_to boards_path
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image)
  end

  def require_login
    unless logged_in?
      redirect_to login_path
      flash[:danger] = t('views.boards.index.login')
    end
  end

  def find_board
    @board = Board.find(params[:id])
  end

  def authorize_user
    unless current_user == @board.user
      raise ActiveRecord::RecordNotFound
    end
  end
end
