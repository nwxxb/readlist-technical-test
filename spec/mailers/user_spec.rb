require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  it "::notify_book_added" do
    user = build_stubbed(:user)
    author = build_stubbed(:author, name: "Plato")
    book = build_stubbed(:book, title: "The Republic", author: author)

    mail = UserMailer.with(user: user, book: book).notify_book_added
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["no-reply@readlist.#{Rails.env.to_s}.com"])
    expect(mail.subject).to eq("Your book title #{book.title} is now added!")
    expect(mail.body.encoded).to match(/added/i)
    expect(mail.body.encoded).to match(user.username)
    expect(mail.body.encoded).to match(book.title)
    expect(mail.body.encoded).to match(book.description)
  end
end
