# README

This is a simple CRUD system project to manage a database of books and authors.

## System dependencies:
- ruby 3.1.2
- redis (6.2.0 or greater)

## Start up
```bash
# one time
bundle install
rails db:create
rails db:migrate
# generate books and author
rails db:seed # please see ./db/seeds.rb

# boot up server
rails s 
# or
./bin/dev

# running test
rspec
# or specify directory/file/line
rspec spec/features
rspec spec/features/models/manage_book_spec.rb
rspec spec/features/models/manage_book_spec.rb:6
```
