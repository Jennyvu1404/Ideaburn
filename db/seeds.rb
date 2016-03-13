admin = User.create!({
  username: 'admin',
  user_type: :admin,
  email: 'admin@ideaburn.com',
  password: '12345678',
  remote_photo_url: Faker::Avatar.image
  })
puts 'CREATED ADMIN USER: ' << admin.email
