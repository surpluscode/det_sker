FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    password 'f4k3p455w0rd'
    username 'f4kIr'
  end

  factory :event do
    title 'Fun party'
    short_description 'really fun party'
    long_description "I'm telling you it's going to be fun!"
    location 'ungdomshuset'
    start_time DateTime.now
    end_time DateTime.now + 5.hours
    user_id 1
  end

  factory :category do
    key :party
    description 'Fun things with hats and glasses'
  end
end