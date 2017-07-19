  users = [
  { email: "a@a.a", password: "roflcat" },
  { email: "b@b.b", password: "hello123" },
]
users.each { |user| User.create(user) }