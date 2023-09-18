class Board < ApplicationRecord
  # titleカラムは最大255文字、bodyカラムは最大65,535文字で、どちらも必須項目
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65535 }

  # Userモデルとのアソシエーション
  belongs_to :user
end
