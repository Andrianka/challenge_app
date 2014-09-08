Then(/^I should have (\d+) points$/) do |points|
  expect(@user.reload.points).to eq(points.to_i)
end

Then(/^I should have (\d+) points for the answer/) do |points|
	expect(@answer.user.reload.points).to eq(points.to_i)
end

Given(/^I have (\d+) points$/) do |points|
  @user.points = points
  @user.save!
end

