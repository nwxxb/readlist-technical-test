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

  scenario "Show all books (paginated, default to 30, order by created_at)" do
    user = create :user
    author = create :author, name: "Socrates"
    create :book, title: "Old Invisible", author: author
    29.times do |i|
      create :book, title: "Book #{i + 1}", author: author
    end
    create :book, title: "Newly Visible", author: author

    sign_in user
    visit root_path

    expect(page.all('th[@scope="row"]').length).to eq(30)
    expect(page).to have_content /Newly Visible/i
    expect(page).to have_content /book 29/i
    expect(page).to_not have_content /Old Invisible/i

    visit root_path + '?page=2'
    expect(page).to have_content /Old Invisible/i
  end
end
