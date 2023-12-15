require 'rails_helper'

RSpec.feature "List available books" do
  scenario "Show all books" do
    user = create :user
    author1 = create :author, name: "Socrates"
    author2 = create :author, name: "Dee Lestari"
    book1 = create :book, title: "Book 1", author: author1
    book2 = create :book, title: "Book 2", author: author1
    book3 = create :book, title: "Book 3", author: author2

    sign_in user
    visit root_path

    expect(page).to have_content /book 1/i
    expect(page).to have_content /book 2/i
    expect(page).to have_content /book 3/i
  end
end
