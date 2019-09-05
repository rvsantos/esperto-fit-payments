FactoryBot.define do
  factory :registration do
    name { 'Fulano de Tal' }
    email { 'email@email.com' }
    cpf { '123456789' }
    unity
    plan
  end
end
