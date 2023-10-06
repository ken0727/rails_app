class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :board

  # コメントが空でないことを検証
  validates :body, presence: true

  # コメントの最大文字数を検証
  validates :body, length: { maximum: 65535 }

end
