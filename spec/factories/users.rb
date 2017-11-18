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

    first_name 'Dexter'
    last_name 'Morgan'
    biography 'A long time ago, in a galaxy far far away, there lived a man named Dexter.'
    password 'letmein123'
    password_confirmation 'letmein123'
    confirmed_at Time.now
  end
end
