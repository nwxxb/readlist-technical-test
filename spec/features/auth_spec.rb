require 'rails_helper'

RSpec.feature "Authentication & Authorization" do
  scenario "Bring visitor directly to sign in page" do
    visit "/"

    expect(page).to have_current_path new_user_session_path
    expect(page).to have_content /sign.+in/i
    expect(page).to have_content /email/i
    expect(page).to have_content /password/i
    expect(page).to have_content /sign.+up/i
    expect(page).to have_selector :link_or_button, "Sign up"
  end

  scenario "User can register" do
    username = "user"
    email = "test@example.com"
    password = "password"
    visit "users/sign_up"

    fill_in "user_username", with: username
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password
    click_button "Sign up"

    expect(page).to have_content /sign.+up.+successfully/i
    expect(page).to have_content /welcome.+#{username}/i
    expect(page).to have_selector :link_or_button, "Sign out"
    expect(page).to have_current_path root_path
  end

  scenario "Sign In And Sign Out correctly" do
    user = create :user
    visit "/users/sign_in"

    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Sign in"
    
    expect(page).to have_content /sign.+in.+successfully/i
    expect(page).to have_content /welcome.+#{user.username}/i
    expect(page).to have_selector :link_or_button, "Sign out"
    expect(page).to have_current_path root_path

    click_button "Sign out"
    expect(page).not_to have_content "#{user.username}"
    expect(page).to have_selector :link_or_button, "Sign in"
    expect(page).to have_selector :link_or_button, "Sign up"
    expect(page).to have_current_path new_user_session_path
  end
end
