class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, presence: true, length: { minimum: 3 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
end
