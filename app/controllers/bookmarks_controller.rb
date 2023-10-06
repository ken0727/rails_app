
class BookmarksController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    current_user.bookmark(@board)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @board = Bookmark.find(params[:id]).board
    current_user.unbookmark(@board)
    respond_to do |format|
      format.js
    end
  end
end
