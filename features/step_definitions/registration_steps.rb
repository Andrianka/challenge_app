require 'securerandom'

When(/^I create a profile$/) do
  email = "email#{SecureRandom.hex(12)}@example.com"

  visit new_user_registration_path
  fill_in "Email", with: email
  fill_in "Password", with: "password"
  fill_in "Password confirmation", with: "password"
  within "div#sign_up" do
  	click_on "Sign up"
  end

  @user = User.find_by(email: email)
end

