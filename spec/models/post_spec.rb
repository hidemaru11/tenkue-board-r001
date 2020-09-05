require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }
  let(:comment) { create(:comment) }

  it "postは有効か" do
    expect(post).to be_valid
  end

  it "空白は無効" do
    post.content = ""
    expect(post).to_not be_valid
  end

  it "文字数140字以上は無効" do
    post.content = "a" * 141
    expect(post).to_not be_valid
  end

  it "user_idがなければ無効" do
    post.user_id = nil
    expect(post).to_not be_valid
  end

  it "投稿内容がnullなら無効" do
    post.content = nil
    expect(post).to_not be_valid
  end

  it "投稿が削除されたら、コメントも削除される" do
    posts = comment
    expect{ posts.post.destroy }.to change{ Comment.count }.by(-1)
  end
end
