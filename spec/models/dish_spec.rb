require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "バリデーションに関するテスト" do
    it "タイトル、説明、画像がある場合は有効" do
      dish = FactoryBot.build(:dish, title: "valid title")
      expect(dish).to be_valid
    end

    it "タイトルがない場合は無効" do
      dish = FactoryBot.build(:dish, title: nil)
      dish.valid?
      expect(dish.errors[:title]).to include("can't be blank")
    end

    it "タイトルが20文字を超える場合は無効" do
      dish = FactoryBot.build(:dish, title: "a"*21)
      dish.valid?
      expect(dish.errors[:title]).to include("is too long (maximum is 20 characters)")
    end

    it "タイトルが20文字以内の場合は有効" do
      dish = FactoryBot.build(:dish, title: "a"*20)
      dish.valid?
      expect(dish).to be_valid
    end

    it "説明文がない場合は無効" do
      dish = FactoryBot.build(:dish, description: nil)
      dish.valid?
      expect(dish.errors[:description]).to include("can't be blank")
    end

    it "画像がない場合は無効" do
      dish = FactoryBot.build(:dish, image: nil)
      dish.valid?
      expect(dish.errors[:image]).to include("can't be blank")
    end
  end

  describe "関連付けに関するテスト" do
    it "ユーザーに属していること" do
      user = FactoryBot.create(:user)
      dish = FactoryBot.build(:dish, user: user)
      expect(dish.user).to eq(user)
    end
  end
end
