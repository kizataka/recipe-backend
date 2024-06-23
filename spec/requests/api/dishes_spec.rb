require 'rails_helper'

RSpec.describe "Api::Dishes", type: :request do
  describe "GET /api/dishes" do
    let!(:dishes) { create_list(:dish, 21) }
    it "レシピの一覧が取得できること" do
      get "/api/dishes"
      expect(response).to have_http_status(200)
      expect(response.parsed_body["dishes"].size).to eq(10)
      expect(response.parsed_body["dishes"][0].keys).to match_array(%w[id title description image created_at updated_at user])
      expect(response.parsed_body["paging"]).to match(
      "total_pages" => 3,
      "total_count" => 21,
      "current_page" => 1
      )
    end
  end

  describe "POST /api/dishes" do
    let(:user) { create(:user) }
    let(:token) { Jwt::TokenProvider.call(user_id: user.id) }
    let(:headers) { { Authorization: "Bearer #{token}" } }
    let(:dish_params) { { title: "hoge", description: "hoge", image: "hoge" } }
    context "ログイン済みの場合" do
      it "レシピが作成できること" do
        expect do
          post("/api/dishes", params: dish_params, headers:, as: :json)
          expect(response).to have_http_status(200)
          expect(response.parsed_body).to match(
            "id" => be_present,
            "title" => "hoge",
            "description" => "hoge",
            "image" => "hoge",
            "created_at" => be_present,
            "updated_at" => be_present,
            "user" => include("id" => user.id)
          )
        end.to change(Dish, :count).by(1)
      end
    end

    context "ログインしていない場合" do
      it "401エラーになること" do
        post "/api/dishes", params: dish_params, as: :json
        expect(response).to have_http_status(401)
        json = response.parsed_body
        expect(json["error"]).to match("messages" => be_present)
      end
    end
  end

  describe "GET /api/dishes/:id" do
    let(:dish) { create(:dish) }
    it "レシピの詳細を取得できること" do
      get "/api/dishes/#{dish.id}"
      expect(response).to have_http_status(200)
      expect(response.parsed_body).to match(
        "id" => dish.id,
        "title" => dish.title,
        "description" => dish.description,
        "image" => dish.image,
        "created_at" => be_present,
        "updated_at" => be_present,
        "user" => include("id" => dish.user.id)
      )
    end
  end

  describe "PATCH /api/dishes/:id" do
    let(:user) { create(:user) }
    let(:token) { Jwt::TokenProvider.call(user_id: user.id) }
    let(:headers) { { Authorization: "Bearer #{token}" } }
    let(:dish) { create(:dish, user:) }
    let(:dish_params) { { title: "hoge", description: "hoge", image: "hoge" } }
    context "ログイン済みの場合" do
      it "レシピの更新ができること" do
        patch("/api/dishes/#{dish.id}", params: dish_params, headers:, as: :json)
        expect(response).to have_http_status(200)
        expect(response.parsed_body).to match(
          "id" => be_present,
          "title" => "hoge",
          "description" => "hoge",
          "image" => "hoge",
          "created_at" => be_present,
          "updated_at" => be_present,
          "user" => include("id" => user.id)
        )
      end
    end

    context "ログインしていない場合" do
      it "401エラーになること" do
        patch "/api/dishes/#{dish.id}", params: dish_params, as: :json
        expect(response).to have_http_status(401)
        json = response.parsed_body
        expect(json["error"]).to match("messages" => be_present)
      end
    end
  end

  describe "DELETE /api/dishes/:id" do
    let(:user) { create(:user) }
    let(:token) { Jwt::TokenProvider.call(user_id: user.id) }
    let(:headers) { { Authorization: "Bearer #{token}" } }
    let(:dish) { create(:dish, user:) }
    context "ログイン済みの場合" do
      it "レシピが削除できること" do
        delete("/api/dishes/#{dish.id}", headers:)
        expect(response).to have_http_status(200)
        expect(response.parsed_body).to match(
          "id" => be_present,
          "title" => dish.title,
          "description" => dish.description,
          "image" => dish.image,
          "created_at" => be_present,
          "updated_at" => be_present,
          "user" => include("id" => user.id)
        )
      end
    end

    context "ログインしていない場合" do
      it "401エラーになること" do
        delete "/api/dishes/#{dish.id}"
        expect(response).to have_http_status(401)
        json = response.parsed_body
        expect(json["error"]).to match("messages" => be_present)
      end
    end
  end
end
