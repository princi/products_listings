FactoryGirl.define do

  factory :product do|f|
    f.description "description1"
    f.name "product1"
    f.price 24

    f.trait(:without_name)   { name nil }
    f.trait(:without_description)   { description nil }
    f.trait(:without_price) {price nil}
    f.trait(:invalid_price) {price "invalid price"}

  end


end
