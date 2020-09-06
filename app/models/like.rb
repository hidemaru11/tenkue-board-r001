class Like < ApplicationRecord
  #モデルの関連定義
  belongs_to :user
  belongs_to :post
  #いいね機能の一意性制約
  validates_uniqueness_of :post_id, scope: :user_id
end
