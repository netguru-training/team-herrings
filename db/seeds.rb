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
  puts 'created user admin ' << admin.email
end

waiters.each do |waiter_params|
  waiter = FactoryGirl.create(:user, :waiter, waiter_params)
  puts 'created user waiter ' << waiter.email
end

guests.each do |guest_params|
  guest = FactoryGirl.create(:user, :guest, guest_params)
  puts 'created user guest ' << guest.email
end

30.times do
  Dish.create!(
    name: Faker::Hipster.word,
    weight: Faker::Number.between(100, 1000),
    vat: Faker::Number.between(0, 23),
    price: Faker::Number.decimal(2),
  )
end
puts 'created thirty random dishes '
# Environment variables (ENV['...']) can be set in the file .env file.
