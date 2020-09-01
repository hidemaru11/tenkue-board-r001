class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :users, through: :likes
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  #ユーザーがいいね済みかどうかを判定
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end
