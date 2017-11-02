FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@gmail.com"
    end

    # sequence :first_name do |n|
    #   "First-#{n}"
    # end
    #
    # sequence :last_name do |n|
    #   "Last-#{n}"
    # end

    password 'letmein123'
    password_confirmation 'letmein123'
    confirmed_at Time.now
  end
end
