require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }

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
end
