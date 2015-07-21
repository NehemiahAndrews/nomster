FactoryGirl.define do
  factory :comment do
    message "Absolutely terrible" 
    rating "1_star"
  end

  factory :user do
    email "nehemiah.andrews@gmail.com"
    password "12345!!!54321"
    password_confirmation "12345!!!54321"
  end

  factory :place do
    name "Home"
    description "There's no place like it"
    address "23127 Violet St, Farmington, MI 48336"
    latitude "42.461418"
    longitude "-83.355656"
  end

end