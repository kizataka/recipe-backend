module Jwt::TokenProvider
    extend self
  
    def call(payload)
      issue_token(payload)
    end
  
    private
  
    def issue_token(payload)
      JWT.encode(payload, Rails.application.secret_key_base)
    end
  end