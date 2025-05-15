FactoryBot.define do
  factory :cart do
    total_price { 0 }
    status { 'active' }

    trait :with_products do
      after(:create) do |cart|
        create_list(:cart_product, 2, cart: cart)
      end
    end
  end
end
