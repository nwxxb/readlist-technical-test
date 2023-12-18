FactoryBot.define do
  factory :book do
    title { "A Book Title" }
    description { "Some Book Description" }
    year_published { 2000 }
    author { nil }
  end
end
