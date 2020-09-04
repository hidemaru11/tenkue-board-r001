class Post < ApplicationRecord
  # モデルの関連定義
  belongs_to :user
  has_many :likes, dependent: :destroy

  # バリデーション
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true


  #ユーザーがいいね済みかどうかを判定
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  # クエリインターフェイス
  # created_atカラムを降順で取得
  scope :sorted_desc, -> { order(created_at: :desc) }
  # usersを事前に読み込み
  scope :includes_user, -> { includes(:user) }

end
