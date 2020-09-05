require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "コメントが無効になるテスト" do
    it "コメントがnullの場合、無効" do
      comment = build(:comment, comment: nil)
      comment.valid?
      expect(comment.errors[:comment]).to include('を入力してください')
    end

    it "コメントの文字数が140以上の場合、無効" do
      comment = build(:comment, comment: "a" * 141)
      comment.valid?
      expect(comment.errors[:comment]).to include('は140文字以内で入力してください')
    end

    it "user_idが無い場合、無効" do
      comment = create(:comment)
      comment.user_id = nil
      expect(comment).to_not be_valid
    end

    it "post_idが無い場合、無効" do
      comment = create(:comment)
      comment.post_id = nil
      expect(comment).to_not be_valid
    end
  end

  describe "コメントが有効になるテスト" do
    it "user_id、post_idが有る場合、有効" do
      user = create(:user)
      post = user.posts.create(content: "test")
      comment = Comment.create(comment: "test", user_id: user.id, post_id: post.id)
      expect(comment).to be_valid
    end

    it "コメントの文字数が140字以内の場合、有効" do
      comment = build(:comment, comment: "a" * 140)
      comment.valid?
      expect(comment).to be_valid
    end
  end
end
