require 'rails_helper'

RSpec.describe "Api::Accounts", type: :request do
  describe "POST /api/account" do
    let(:user_params) do
      { name: "kizataka", email: "kizataka@example.com", password: "12345678", password_confirmation: "12345678"}
    end
    it "ユーザー作成ができること" do
      expect do
        post "/api/account", params: user_params, as: :json
        expect(response).to have_http_status(200)
        expect(response.parsed_body).to match({
          "id" => be_present,
          "name" => "kizataka",
          "email" => "kizataka@example.com",
        })
      end.to change { User.count }.by(1)
    end

    let(:invalid_user_params) do
      { name: "kizataka", email: "kizataka@email.com", password: "12345678", password_confirmation: "1234"}
    end
    it "ユーザーの作成に失敗すること" do
      post "/api/account", params: invalid_user_params, as: :json
      expect(response).to have_http_status(422)
      expect(response.parsed_body["error"]).to be_present
    end
  end
end
