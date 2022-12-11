#Group

User.destroy_all
puts "deleted users"
Wishlist.destroy_all
puts "deleted wishlists"
Group.destroy_all
puts "deleted groups"
Gift.destroy_all
puts "deleted gifts"
Invitation.destroy_all
puts "deleted invites"

kubi = User.create(name: "kubi", email: "kubi@gmail.com", password: "hello123", password_confirmation: "hello123")

handshq = Group.create(name: "HandsHq", budget: 100)

wishlist_one = Wishlist.create(user_id: kubi.id)

iphone = Gift.create(name: "iPhone", price: 10, description: "Over priced", wishlist_id: wishlist_one.id)
chair = Gift.create(name: "Gaming Chair", price: 100, description: "If you really like me :P ", wishlist_id: wishlist_one.id)
jordans = Gift.create(name: "Jordan retro 4", price: 150, description: "Got to be in it to win it", wishlist_id: wishlist_one.id)
job = Gift.create(name: "Job at HandsHQ", price: 0, description: "Priceless", wishlist_id: wishlist_one.id)

puts "created group"


#Users
ali = User.create(name: "ali", email: "ali@example.com", password: "ali123", password_confirmation: "ali123")
sarah = User.create(name: "sarah", email: "sarah@example.com", password: "sarah123", password_confirmation: "sarah123")
maya = User.create(name: "maya", email: "maya@example.com", password: "maya123", password_confirmation: "maya123")
elif = User.create(name: "elif", email: "elif@example.com", password: "elif123", password_confirmation: "elif123")
josh = User.create(name: "josh", email: "josh@example.com", password: "josh123", password_confirmation: "josh123")
dan = User.create(name: "dan", email: "dan@example.com", password: "dan123", password_confirmation: "dan123")

puts "added users"
