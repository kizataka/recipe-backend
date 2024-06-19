FactoryBot.define do
  factory :dish do
    title { Faker::Food.dish }
    description { Faker::Food.description }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/dummy.png'), 'image/png') }
    user
  end
end