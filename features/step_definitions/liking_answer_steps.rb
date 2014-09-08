And(/^I like that answer$/) do
  visit question_path(@answer.question)
  within "div#answer-#{@answer.id}" do
    click_on "Like"
  end
end

Then(/^That answer should have (\d+) like(s?)$/) do |count, suffix|
  within "div#answer-#{@answer.id}" do
    expect(page).to have_content("#{count} like#{suffix}")
  end
end

When(/^This answer is liked$/) do
  click_on "Sign out"
  sign_in_as(@answer.question.user)
  visit question_path(@answer.question)
  within "div#answer-#{@answer.reload.id}" do
    click_on "Like"
  end
  #expect(@answer.user.points).to eq(105)

end

When(/^This answer is accepted$/) do
  click_on "Sign out"
  sign_in_as(@answer.question.user)
  visit question_path(@answer.question)
  within "div#answer-#{@answer.id}" do
    click_on "Accept"
  end

  #expect(@answer.user.reload.points).to eq(125)
end
