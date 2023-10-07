class BookmarksController < ApplicationController

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

  redirect_to boards_path
end

end