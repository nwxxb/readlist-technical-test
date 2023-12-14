require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should validate_uniqueness_of(:username) }
  it do
    # ignoring_case_sensitivity : ignoring case sensitivity check
    # devise by default lowercase incoming email input
    # please see matchers.shoulda.io/docs/v5.3.0/Shoulda/Matchers/ActiveRecord.html#validate_uniqueness_of-instance_method
    should validate_uniqueness_of(:email).ignoring_case_sensitivity
  end
end
