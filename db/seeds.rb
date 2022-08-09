User.destroy_all
Product.destroy_all
user = User.create! email: 'saurabh@gmail.com', password: 'foobar'
puts "Created a new user: #{user.email}"
product = Product.create!(
  title: Faker::Commerce.product_name,
  price: rand(1.0..100.0),
  published: true,
  user_id: user.id
)
puts "Created a brand new product: #{product.title}"

3.times do
  user = User.create! email: Faker::Internet.email, password:'password'
  puts "Created a new user: #{user.email}"
  2.times do
    product = Product.create!(
      title: Faker::Commerce.product_name,
      price: rand(1.0..100.0),
      published: true,
      user_id: user.id
    )
    puts "Created a brand new product: #{product.title}" 
  end
end