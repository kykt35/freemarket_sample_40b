FactoryBot.define do
  factory :category, class: Category do
    sequence(:name) { |n| "#{n}_category" }
    hasBrand { true }
    factory :category_child do |f|
      f.parent { FactoryBot.create(:category) }

      factory :category_grandchild do |f|
        f.parent { FactoryBot.create(:category_child) }
      end
    end

  end
end
