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

    expect(ActiveJob::Base.queue_adapter.enqueued_jobs.length).to eq(1)
    expect(
      ActiveJob::Base.queue_adapter.enqueued_jobs.first[:args]).to include("UserMailer", "notify_book_added")
    perform_enqueued_jobs
    expect(ActiveJob::Base.queue_adapter.enqueued_jobs.length).to eq(0)
    expect(UserMailer.deliveries.length).to eq(1)
  end
end
