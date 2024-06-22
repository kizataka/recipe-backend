require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  describe "GET /api/users/:id" do
    let(:user) { create(:user) }
    it "ユーザーの詳細が取得できること" do
      get "/api/users/#{user.id}"
      expect(response).to have_http_status(200)
      expect(response.parsed_body).to match("id" => user.id,
                                            "name" => user.name
                                            )
    end
  end
end
