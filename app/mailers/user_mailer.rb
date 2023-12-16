class UserMailer < ApplicationMailer
  default from: "no-reply@readlist.#{Rails.env}.com"

  def notify_book_added
    @user = params[:user]
    @book = params[:book]

    mail(to: @user.email, subject: "Your book title #{@book.title} is now added!")
  end
end
