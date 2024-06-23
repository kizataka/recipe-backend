require 'rails_helper'

RSpec.describe "Api::Sessions", type: :request do
  describe "POST /api/session" do
    let!(:user) { create(:user) }  # 全てのテストが始まる前に作成されている必要がある
    context "認証情報が正しい場合" do
      let(:session_params) { { email: user.email, password: "12345678" } }
      it "ログインに成功すること" do
        post "/api/session", params: session_params,  as: :json
        expect(response).to have_http_status(200)
        expect(response.parsed_body["token"]).to be_a(String)
      end
    end

    context "認証情報に誤りがある場合" do
      let(:invalid_session_params) { { session: { email: user.email, password: "1234" } } }
      it "ログインに失敗すること" do
        post "/api/session", params: invalid_session_params
        expect(response).to have_http_status(401)
        expect(response.parsed_body["error"]).to be_present
      end
    end
  end
end
