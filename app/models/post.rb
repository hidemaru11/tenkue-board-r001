class Post < ApplicationRecord
  # モデルの関連定義
  belongs_to :user
  has_many :comments, dependent: :destroy
  # バリデーション
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  # クエリインターフェイス
  # created_atカラムを降順で取得
  scope :sorted_desc, -> { order(created_at: :desc) }
  # usersを事前に読み込み
  scope :includes_user, -> { includes(:user) }
end
