class Board < ApplicationRecord
  # titleカラムは最大255文字、bodyカラムは最大65,535文字で、どちらも必須項目

validates :title, presence: true, length: { maximum: 255 }
validates :body, presence: true, length: { maximum: 65535 }

  mount_uploader :board_image, BoardImageUploader
  # Userモデルとのアソシエーション
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy
    has_many :bookmarks
  has_many :users_who_bookmarked, through: :bookmarks, source: :user
end
