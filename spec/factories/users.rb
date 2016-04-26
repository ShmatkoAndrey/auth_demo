FactoryGirl.define do
  factory :user do
    login Faker::Internet.user_name
    password_secret Random.new_seed
  end
end