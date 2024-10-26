# db/seeds.rb

# Clear existing data (optional, for development purposes)
Category.destroy_all

# Create categories
categories =  [ "Science",
  "Technology",
  "Art",
  "Literature",
  "History",
  "Mathematics",
  "Health",
  "Business",
  "Philosophy",
  "Education",
  "Environment",
  "Politics",
  "Society",
  "Travel",
  "Sports",
  "Food"
]

categories.each do |category_name|
  Category.find_or_create_by(name: category_name)
end
