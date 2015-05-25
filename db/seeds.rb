10.times do |n|
  name = "Category #{n+1}"
  Category.create!(name: name)
end
