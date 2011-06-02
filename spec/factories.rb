# by using the symbol ':user',we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                   "brook"
  user.email                  "brook@qq.com"
  user.password               "brookkkk"
  user.password_confirmation  "brookkkk"
end