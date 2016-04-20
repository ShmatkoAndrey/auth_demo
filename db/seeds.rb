(0..10).each {
  User.create(login: Faker::Internet.email.split('@').first, password_secret: Digest::SHA256.hexdigest('123'))
}