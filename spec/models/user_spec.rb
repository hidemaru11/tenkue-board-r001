require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションテスト' do
    context 'パスワード' do
      context '無効' do
        it '全角英字が含まれた場合、無効' do
          user = build(:user, password: 'A' * 8)
          user.valid?
          expect(user.errors[:password]).to include('は半角英字と半角数字のいずれとも含まれ、8文字以上32文字以下である必要があります')
        end
      
        it '半角英字が含まれない場合、無効' do
          user = build(:user, password: '1' * 8)
          user.valid?
          expect(user.errors[:password]).to include('は半角英字と半角数字のいずれとも含まれ、8文字以上32文字以下である必要があります')
        end
      
        it '半角数字が含まれない場合、無効' do
          user = build(:user, password: 'a' * 8)
          user.valid?
          expect(user.errors[:password]).to include('は半角英字と半角数字のいずれとも含まれ、8文字以上32文字以下である必要があります')
        end
      
        it '７文字未満は、無効' do
          user = build(:user, password: 'a' * 7)
          user.valid?
          expect(user.errors[:password]).to include('は半角英字と半角数字のいずれとも含まれ、8文字以上32文字以下である必要があります')
        end
      
        it '33文字以上から、無効' do
          user = build(:user, password: 'a' * 33)
          user.valid?
          expect(user.errors[:password]).to include('は半角英字と半角数字のいずれとも含まれ、8文字以上32文字以下である必要があります')
        end

        it '空白の場合、無効' do
          user = build(:user, password: '')
          user.valid?
          expect(user.errors[:password]).to include('を入力してください')
        end
      end
      context '有効' do
        it '半角英字、半角数字が含まれ、8文字以上の場合、有効' do
          user = build(:user, password: '1a' * 4)
          user.valid?
          expect(user).to be_valid
        end

        it '半角英字、半角数字が含まれ、32文字以下の場合、有効' do
          user = build(:user, password: '1a' * 16)
          user.valid?
          expect(user).to be_valid
        end
      end
    end

    context 'メール' do
      context '無効' do
        it '全角文字が含まれている場合、無効' do
          user = build(:user, email: 'Ｙamamoto@gmail.com')
          user.valid?
          expect(user.errors[:email]).to include('は不正な値です')
        end

        it '空白の場合、無効' do
          user = build(:user, email: '')
          user.valid?
          expect(user.errors[:email]).to include('を入力してください')
        end

        it 'すでに登録しているメールアドレスは登録出来ない' do
          user = create(:user)
          other_user = build(:user)
          other_user.valid?
          expect(other_user.errors[:email]).to include('はすでに存在します')
        end
      end
    
      context '有効' do
        it '半角英字と半角数字のいずれとも含まれ、8文字以上32文字以下であれば登録出来る' do
          user = create(:user, email: 'tenkuetaro@gmail.com')
          user.valid?
          expect(user).to be_valid
        end
      end
    end
  end

  it "userが削除されれば、postも削除される" do
    user = create(:user)
    user.posts.create(content: "test_post")
    expect{ user.destroy }.to change{ Post.count }.by(-1)
  end
end