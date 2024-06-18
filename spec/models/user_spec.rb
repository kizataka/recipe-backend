require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザーのバリデーションに関するテスト" do
    it "名前、メール、パスワードがある場合は有効" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it "名前がない場合は無効" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "メールがない場合は無効" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "メールアドレスが重複している場合は無効" do
      FactoryBot.create(:user, email: "kizataka@example.com")
      user = FactoryBot.build(:user, email: "kizataka@example.com")
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "パスワードがない場合は無効" do
      user = FactoryBot.build(:user, password_digest: nil)
      user.valid?
      expect(user.errors[:password_digest]).to include("can't be blank")
    end

    it "パスワード（確認用）とパスワードが一致しない場合は無効" do
      user = FactoryBot.build(:user, password_digest: "password", password_confirmation: "different")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end
end
