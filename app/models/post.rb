class Post < ApplicationRecord
  # モデルの関連定義
  belongs_to :user

  # バリデーション
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  
  # created_atカラムを降順で取得
  scope :sorted_desc, -> { order(created_at: :desc) }
end
