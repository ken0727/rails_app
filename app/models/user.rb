class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :last_name, presence: true, length: { maximum: 255 }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :email, uniqueness: true
  validates :email, presence: true

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks
  has_many :bookmarked_boards, through: :bookmarks, source: :board

  def full_name
    "#{first_name} #{last_name}"
  end

  def avatar_url
    # アバターのURLを生成する
    # 例えば、Gravatar を使ってアバターを取得する場合
     gravatar_id = Digest::MD5.hexdigest(email.downcase)
     "https://www.gravatar.com/avatar/#{gravatar_id}"
  end
end