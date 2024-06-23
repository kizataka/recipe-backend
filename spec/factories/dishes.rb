FactoryBot.define do
  factory :dish do
    title { Faker::Lorem.characters(number: 20) }  # 20文字以内のランダムな文字列
    description { Faker::Food.description }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/dummy.png'), 'image/png') }
    user
  end
end