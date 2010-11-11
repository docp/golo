# By using the symbol ':user', Factory Girl simulates the User model.
Factory.define :user do |user|
  user.name                     "Max Mustermann"
  user.email                    "Max@Mustermann.biz"
  user.city                     "Musterstadt"
  user.password                 "Very_Geheim"
  user.password_confirmation    "Very_Geheim"
end

Factory.sequence :email do |n| "Max#{n}@Mustermann.biz" end

