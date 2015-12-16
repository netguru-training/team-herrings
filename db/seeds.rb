logger = Logger.new(STDOUT)

admins = [
    {
        name: Rails.application.secrets.admin_name,
        email: Rails.application.secrets.admin_email,
        password: Rails.application.secrets.admin_password,
        password_confirmation: Rails.application.secrets.admin_password
    }
]
waiters = [
    {
        name: Rails.application.secrets.waiter_name,
        email: Rails.application.secrets.waiter_email,
        password: Rails.application.secrets.waiter_password,
        password_confirmation: Rails.application.secrets.waiter_password
    }
]
guests = [
    {
        name: Rails.application.secrets.guest_name,
        email: Rails.application.secrets.guest_email,
        password: Rails.application.secrets.guest_password,
        password_confirmation: Rails.application.secrets.guest_password
    }
]

admins.each do |admin_params|
  admin = FactoryGirl.create(:user, :admin, admin_params)
  logger.debug 'created user admin ' << admin.email
end

waiters.each do |waiter_params|
  waiter = FactoryGirl.create(:user, :waiter, waiter_params)
  logger.debug 'created user waiter ' << waiter.email
end

guests.each do |guest_params|
  guest = FactoryGirl.create(:user, :guest, guest_params)
  logger.debug 'created user guest ' << guest.email
end

5.times do
  Category.create!(
    name: Faker::Hipster.word,
  )
end

categories = Category.all

30.times do
  Dish.create!(
    name: Faker::Hipster.word,
    weight: Faker::Number.between(100, 1000),
    vat: Faker::Number.between(0, 23),
    price: Faker::Number.decimal(2),
    category: categories.sample
  )
end

30.times do
  Table.create!(
    places: rand(2..10),
    location: Table.locations.keys.sample
  )
end

TIME_FROM = Time.zone.parse('2015-12-13 9:00:00 UTC')
TIME_TO = Time.zone.parse('2016-02-13 9:00:00 UTC')

tables = Table.all
10.times do
  first_name = Faker::Name.first_name
  status = rand(0..2)
  Booking.create!(
    date: rand(TIME_FROM..TIME_TO),
    status: [0,2].sample,
    table: tables.sample,
    customer: Customer.new(first_name: first_name,
                           last_name: Faker::Name.last_name,
                           email: Faker::Internet.email(first_name)),
    reject_reason: nil
  )
end

10.times do
  first_name = Faker::Name.first_name
  status = 0
  Booking.create!(
    date: rand(TIME_FROM..TIME_TO),
    status: 0,
    table: tables.sample,
    customer: Customer.new(first_name: first_name,
                           last_name: Faker::Name.last_name,
                           email: Faker::Internet.email(first_name)),
    reject_reason: status == 1 ? Faker::Lorem.sentence(3) : nil
  )
end

logger.debug 'created thirty random dishes '
# Environment variables (ENV['...']) can be set in the file .env file.
