FactoryBot.define do
  factory :comment do
    comment { "テストコメントだよ" }
    association :post
    user { post.user }
  end
end
