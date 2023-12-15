require 'rails_helper'

RSpec.describe Book, type: :model do
  it "is expected to validate that :title cannot be empty" do
    new_book = build :book, title: "", description: ""

    new_book.validate

    expect(new_book.errors[:title]).to include("can't be blank")
  end

  it "is expected to validate that :author cannot be empty/falsy" do
    author = create :author, name: "Socrates"
    new_book = build :book, title: "Final Quotes"

    new_book.validate

    expect(new_book.errors[:author]).to include("must exist")
  end

  it "is expected to belongs to only one author" do
    author = create :author, name: "Socrates"
    new_book = create :book, title: "Final Quotes", author: author

    expect(new_book.author.id).to eq(author.id)
    expect(new_book.author.name).to eq(author.name)
  end
end
