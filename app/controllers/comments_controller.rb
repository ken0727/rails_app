class CommentsController < ApplicationController
def create
    @board = Board.find(params[:board_id]) # 該当の掲示板を取得
    @comment = @board.comments.build(comment_params.merge(user_id: current_user.id))


    if @comment.save
      flash[:success] = "コメントが投稿されました。"
    else
      flash[:error] = "コメントの投稿に失敗しました。"
      puts @comment.errors.full_messages
    end

    redirect_to board_path(@board) # 元の掲示板詳細ページにリダイレクト
  end

def show
  @board = Board.find(params[:id])
  @comments = @board.comments # この行でコメントを取得
  puts @comments
end

  def edit
    @comment = Comment.find(params[:id]) # 編集対象のコメントを取得
  end

  def update
  @comment = Comment.find(params[:id]) # 更新対象のコメントを取得
  if @comment.update(comment_params)
    flash[:success] = "コメントが更新されました。"
    redirect_to board_path(@comment.board) # コメントが紐づく掲示板詳細ページにリダイレクト
  else
    flash[:error] = "コメントの更新に失敗しました。"
    render :edit # エラー時は編集ページを再表示
  end
end


    def destroy
    @comment = Comment.find(params[:id]) # 削除対象のコメントを取得
    if @comment.destroy
      flash[:success] = "コメントが削除されました。"
    else
      flash[:error] = "コメントの削除に失敗しました。"
    end
    redirect_to board_path(@comment.board) # コメントが紐づく掲示板詳細ページにリダイレクト
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id) # 必要に応じてコメントの属性を調整
  end
end