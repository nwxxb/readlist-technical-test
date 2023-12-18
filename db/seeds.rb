# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
["admin1", "admin2"].each do |username|
  email = "#{username}@example.com"
  password = "password"
  user = User.create_with(
    username: username, 
    password: password,
    password_confirmation: password
  ).find_or_create_by!(
    email: email,
  )
end

words = File.open("./db/fake_words.txt").read.split("\n")
File.open("./db/fake_author_name.txt").read.split("\n").each do |name|
  author = Author.find_or_create_by!(name: name)

  2.times do
    random_int = [rand(words.length), rand(words.length)]
    title = "#{words[random_int.first]} #{words[random_int.last]}"
    year_published = Random.new.rand(990..(Time.now.year))
    description = if random_int.first >= 0 && random_int.first <= 5
                    LoremIpsum.random(paragraphs: 1)
                  elsif random_int.first >= 6 && random_int.first <= 10
                    LoremIpsum.random(paragraphs: 2)
                  else
                    LoremIpsum.random(paragraphs: 3)
                  end

    Book
      .create_with(description: description, year_published: year_published)
      .find_or_create_by!(title: title, author: author)
  end
end
