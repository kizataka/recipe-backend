require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザーのバリデーションに関するテスト" do
    it "名前、メール、パスワードがある場合は有効" do
      user = User.new(
        name: "kizataka",
        email: "kizataka@example.com",
        password_digest: "kizataka-password"
      )
      expect(user).to be_valid
    end

    it "名前がない場合は無効" do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "メールがない場合は無効" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "メールアドレスが重複している場合は無効" do
      User.create(
        name: "kizataka",
        email: "kizataka@example.com",
        password_digest: "kizataka-password",
      )
      user = User.new(
        name: "takataka",
        email: "kizataka@example.com",
        password_digest: "kizataka-password"
      )
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "パスワードがない場合は無効" do
      user = User.new(password_digest: nil)
      user.valid?
      expect(user.errors[:password_digest]).to include("can't be blank")
    end

    it "パスワード（確認用）とパスワードが一致しない場合は無効" do
      user = User.new(
        name: "kizataka",
        email: "kizataka@example.com",
        password: "kizataka-password",
        password_confirmation: "takataka-password"
      )
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end
end
