require "rails_helper"

RSpec.feature "JSON API for User", type: :request do
  scenario "User can request all books in json format" do
    author = create :author, name: "Plato"
    create :book, title: "Plato's Wisdom", author: author
    create :book, title: "Plato's Life", author: author
    
    get "/api/books"

    parsed_body = JSON.parse(response.body)
    expect(response).to have_http_status(:ok)
    expect(parsed_body.length).to be(2)
    expect(parsed_body[0].keys).to eq(["id", "title", "description"])
  end

  scenario "User can request see book detail in json format" do
    selected_author = create :author, name: "Plato"
    selected_book = create :book, title: "Plato's Wisdom", author: selected_author
    create :book, title: "Plato's Life", author: selected_author

    get "/api/books/#{selected_book.id}"

    parsed_body = JSON.parse(response.body)
    expect(response).to have_http_status(:ok)
    expect(parsed_body.keys).to eq(["id", "title", "description", "author"])
    expect(parsed_body["title"]).to eq(selected_book.title)
    expect(parsed_body["author"]["name"]).to eq(selected_author.name)
  end
end
