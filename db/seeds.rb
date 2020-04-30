# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Test User
User.create!(email: 'admin_user@snapask.test', password: 'adminadmin', admin: true)
user_one = User.create!(email: 'test_user1@snapask.test',  password: 'secretsecret')
user_two = User.create!(email: 'test_user2@snapask.test',  password: 'secretsecret')

# Test Courses and Categories
courses = [
  { id: 1, title: 'Chinese: Lesson 1', url: 'https://snapask_chinese_1.com',
    currency: 'TWD', price: '100',
    starts_at: '2020-01-01 00:00:00', ends_at: '2021-01-01 00:00:00', expiry_period: 1 },
  { id: 2, title: 'English: Lesson 1', url: 'https://snapask_english_1.com',
    currency: 'TWD', price: '120',
    starts_at: '2020-04-01 00:00:00', ends_at: '2020-06-01 00:00:00', expiry_period: 2 },
  { id: 3, title: 'English: Lesson 2', url: 'https://snapask_english_2.com',
    currency: 'TWD', price: '120',
    starts_at: '2020-06-01 00:00:00', ends_at: '2020-08-01 00:00:00', expiry_period: 2 }
]
courses.each do |course|
  Course.create!(course)
end

categories = [
  { id: 1, name: 'High School Subject' },
  { id: 2, name: 'English Taught' }
]
categories.each do |category|
  Category.create!(category)
end

course_categories = [
  { course_id: 1, category_id: 1 },
  { course_id: 2, category_id: 1 },
  { course_id: 2, category_id: 2 },
  { course_id: 3, category_id: 1 },
  { course_id: 3, category_id: 2 }
]
course_categories.each do |course_category|
  CourseCategory.create!(course_category)
end

# Test User Courese and Payments
user_payments = [
  { id: 1, user: user_one, payment_method: :atm,
    currency: 'TWD', price: '100', purchased_at: '2020-04-01 00:00:00' },
  { id: 2, user: user_one, payment_method: :atm,
    currency: 'TWD', price: '120', purchased_at: '2020-04-28 00:00:00' },
  { id: 3, user: user_two, payment_method: :credit_card,
    currency: 'TWD', price: '120', purchased_at: '2020-04-28 00:00:00' }
]
user_payments.each do |user_payment|
  UserPayment.create!(user_payment)
end

user_courses = [
  { user: user_one, course_id: 1, payment_id: 1, expires_at: '2020-04-02 00:00:00', is_used: true },
  { user: user_one, course_id: 1, payment_id: 2, expires_at: '2020-04-30 00:00:00' },
  { user: user_two, course_id: 2, payment_id: 3, expires_at: '2020-04-30 00:00:00' }
]
user_courses.each do |user_course|
  UserCourse.create!(user_course)
end
