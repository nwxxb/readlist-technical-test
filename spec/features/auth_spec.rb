require 'rails_helper'

RSpec.feature "Authentication & Authorization" do
  scenario "User can register" do
    username = "user"
    email = "test@example.com"
    password = "password"
    visit new_user_registration_path

    fill_in "user_username", with: username
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password
    click_button "Sign Up"

    expect(page).to have_content /sign.+up.+successfully/i
    expect(page).to have_content /welcome.+#{username}/i
    expect(page).to have_selector :link_or_button, "Sign Out"
    expect(page).to have_current_path root_path
  end

  scenario "Sign In And Sign Out correctly" do
    user = create :user
    visit new_user_session_path

    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Sign In"
    
    expect(page).to have_content /sign.+in.+successfully/i
    expect(page).to have_content /welcome.+#{user.username}/i
    expect(page).to have_selector :link_or_button, "Sign Out"
    expect(page).to have_current_path root_path

    click_button "Sign Out"
    expect(page).not_to have_content "#{user.username}"
    expect(page).to have_selector :link_or_button, "Sign In"
    expect(page).to have_selector :link_or_button, "Sign Up"
    expect(page).to have_current_path root_path
  end
end
