require "rails_helper"

RSpec.feature "User can manage book" do
  include ActiveJob::TestHelper

  scenario "User can create new book (and get email notification)" do
    author = create :author, name: "Plato"

    sign_in create(:user)
    visit new_book_path
    fill_in "book_title",       with: "The Republic"
    fill_in "book_description", with: "a philosophy book by Plato"
    select "Plato", from: "book[author_id]"
    click_button "Add new book"

    expect(page).to have_current_path root_path
    expect(page).to have_content /the.+republic.+created.+successfully/i
    expect(page).to have_content /the.+republic/i
    expect(page).to have_content /a.+philosophy/i
    expect(page).to have_content /Plato/i

    perform_enqueued_jobs
    expect(UserMailer.deliveries.length).to eq(1)
  end
end