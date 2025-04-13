FactoryBot.define do
  factory :subscription do
    user { nil }
    fanclub { nil }
    start_date { "2025-04-11" }
    end_date { "2025-04-11" }
    status { "MyString" }
  end
end
