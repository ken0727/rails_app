class CommentsController < ApplicationController
  before_action :find_board, only: [:create, :show]
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def load_comments
    @board=Board.find(params[:board_id])
    @comments=@board.comments
  end

  def create
    @board=Board.find(params[:board_id])
    @comment = @board.comments.build(comment_params.merge(user_id: current_user.id))
    
    respond_to do |format|
      if @comment.save
        format.js do
        # コメント成功時のJavaScriptレスポンスを返す
        end
      else
        format.js do
        # コメントの保存が失敗した場合にAjaxエラーレスポンスを返す
        render :js => "alert('コメントを入力してください');"
        end
      end
    end
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
      @board=Board.find(params[:board_id])
      @comment=Comment.find(params[:id])

      respond_to do |format|
    if @comment.destroy
      format.html do
      flash[:success] = "コメントが削除されました。"
      redirect_to board_path(@comment.board)
      end

      format.js do
        # コメントの削除成功時のJavaScriptレスポンスを返す
      end
    else
      format.html do
      flash[:error] = "コメントの削除に失敗しました。"
      redirect_to board_path(@comment.board)
    end
      format.js do
        render :js => "alert('コメントの削除に失敗しました.');"
      end
    end
  end
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
