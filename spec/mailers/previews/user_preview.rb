# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview
  def notify_book_added
    user = FactoryBot.build_stubbed(:user, username: "user_tests")
    author = FactoryBot.build_stubbed(:author, name: "author_tests")
    book = FactoryBot.build_stubbed(
      :book, title: "title_tests",
      description: "This is just a test for description",
      author: author
    )

    UserMailer.with(user: user, book: book).notify_book_added
  end
end
