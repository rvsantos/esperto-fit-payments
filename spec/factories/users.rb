FactoryBot.define do
  factory :user do
    email { 'admin@email.com' }
    password { 123456 }
    admin { true }
  end
end
