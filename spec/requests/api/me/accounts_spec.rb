require 'rails_helper'

RSpec.describe "Api::Me::Accounts", type: :request do
  describe "PATCH /api/me/account" do
    let(:user) { create(:user) }
    let(:token) { Jwt::TokenProvider.call(user_id: user.id) }
    let(:headers) { { Authorization: "Bearer #{token}", ContentType: "multipart/formdata" } }
    let(:user_params) do
      { name: "update_name"}
    end

    it "ユーザー名が変更できること" do
      expect do
        patch("/api/me/account", params: user_params, headers:)
        expect(response).to have_http_status(200)

        expect(response.parsed_body).to match({
          "id" => user.id,
          "name" => "updated_name",
          "email" => user.email
        })
      end
    end
  end
end
