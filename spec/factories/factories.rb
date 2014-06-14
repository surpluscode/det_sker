FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    password 'f4k3p455w0rd'
    username 'f4kIr'
    confirmed_at DateTime.now

    factory :admin_user do
      email 'admin@user.com'
      username 'admin'
      is_admin true
    end

    factory :different_user do
      email 'different@user.com'
      username 'different'
    end
  end

  factory :event do
    title 'Fun party'
    short_description 'really fun party'
    long_description "I'm telling you it's going to be fun!"
    start_time DateTime.now
    end_time DateTime.now + 5.hours
    location_id 1
    user_id 1

    factory :event_yesterday do
      title 'This happened yesterday'
      start_time {DateTime.now - 1.days - 2.hours}
      end_time {DateTime.now - 1.days}
    end

    factory :event_tomorrow do
      title 'This will happen tomorrow'
      start_time {DateTime.now + 1.day}
      end_time {DateTime.now + 1.day + 2.hours}
    end
  end

  factory :category do
    key :party
    description 'Fun things with hats and glasses'
  end

  factory :location do
    name 'Folkets Hus'
    street_address 'Stengade 50'
    postcode '2200'
    town 'Nørrebro'
    description 'Folkets Hus er et lokalt, social og politisk brugerstyret hus i hjertet af Nørrebro.'
    latitude 12.554228
    longitude 55.687301
  end
end