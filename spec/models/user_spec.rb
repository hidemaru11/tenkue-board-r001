require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションテスト' do
    context 'パスワード' do
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
    
      it '８文字以下の場合、無効' do
        user = build(:user, password: 'a' * 7)
        user.valid?
        expect(user.errors[:password]).to include('は半角英字と半角数字のいずれとも含まれ、8文字以上32文字以下である必要があります')
      end
    
      it '32文字以上の場合、無効' do
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
    context 'メール' do
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
  end
end
