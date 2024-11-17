# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    name { Faker::Name.unique.name }
    email { Faker::Internet.email }
    width { 4 }
    height { 4 }
    number_of_mines { 2 }
  end
end
