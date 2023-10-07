class BookmarksController < ApplicationController

  def index 
    @boards = Board.all
    @bookmarked_boards = current_user.bookmarked_boards
  end

  def create
    board = Board.find(params[:board_id])
    bookmark = board.bookmarks.build(user_id: current_user.id)
    if bookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

def destroy
  # ユーザーが現在のボードに関連付けたブックマークを見つけます
  bookmark = current_user.bookmarks.find_by(board_id: params[:board_id])
  
  if bookmark.present?
    bookmark.destroy
  end
  
  # リダイレクト先を条件に応じて設定
  if request.referer.include?("bookmarks")
    # ブックマーク一覧ページから来た場合
    redirect_to bookmarks_boards_path
  else
    # それ以外の場合（掲示板一覧ページから来た場合を含む）
    redirect_to boards_path
  end
end


end