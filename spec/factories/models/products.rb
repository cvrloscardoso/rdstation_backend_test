FactoryBot.define do
  factory :product do
    name { FFaker::Vehicle.make }
    price { 1000 }
  end
end
