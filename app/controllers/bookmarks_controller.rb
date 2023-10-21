class BookmarksController < ApplicationController

def index
  @boards = Board.all

  # ユーザーがブックマークしたボードを取得
  bookmarked_boards = current_user.bookmarked_boards

  # ページネーションを適用
  @bookmarked_boards = bookmarked_boards.page(params[:page])
end

def create
  @board = Board.find(params[:board_id])
  bookmark = @board.bookmarks.build(user_id: current_user.id)

  bookmark.save
  respond_to do |format|
    format.js # ブックマーク成功時のJavaScriptレスポンスを返す
  end
  
end

def destroy
  # ユーザーが現在のボードに関連付けたブックマークを見つけます
  bookmark = current_user.bookmarks.find_by(board_id: params[:board_id])

    bookmark.present?
    @board = bookmark.board
    bookmark.destroy

  respond_to do |format|
    format.js # ブックマーク解除用のJavaScriptレスポンスを返す
  end

end

end