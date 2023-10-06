class CommentsController < ApplicationController
  before_action :find_board, only: [:create, :show]
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def create
    @comment = @board.comments.build(comment_params.merge(user_id: current_user.id))
    
    if @comment.save
      flash[:success] = "コメントが投稿されました。"
    else
      flash[:error] = "コメントの投稿に失敗しました。"
      puts @comment.errors.full_messages
    end
    
    redirect_to board_path(@board)
  end

  def show
    @comments = @board.comments
    puts @comments
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = "コメントが更新されました。"
      redirect_to board_path(@comment.board)
    else
      flash[:error] = "コメントの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      flash[:success] = "コメントが削除されました。"
    else
      flash[:error] = "コメントの削除に失敗しました。"
    end
    
    redirect_to board_path(@comment.board)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end

  def find_board
    @board = Board.find(params[:board_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_user
    unless current_user == @comment.user
      raise ActiveRecord::RecordNotFound
    end
  end
end
