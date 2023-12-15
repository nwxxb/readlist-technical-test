require 'rails_helper'

RSpec.describe Author, type: :model do

  # is expected to validate that :password cannot be empty/falsy
  it "is expected to validate that name is unique" do
    create :author, name: "Socrates"

    new_author = build :author, name: "Socrates"
    new_author.validate

    expect(new_author).to_not be_valid
    expect(new_author.errors[:name]).to include("has already been taken")
  end

  it "is expected to validate that name cannot be empty" do
    new_author = build :author, name: ""

    new_author.validate

    expect(new_author.errors[:name]).to include("can't be blank")
  end

  it "is expected to has many Books" do
    author = create :author, name: "Socrates"

    create :book, author: author
    create :book, author: author
    create :book, author: author

    expect(author.books.length).to eq(3)
  end
end
