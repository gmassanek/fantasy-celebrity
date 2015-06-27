When(/^I go to a page$/) do
  visit "/leagues/2/scoring"
end

Then(/^I should see something from the ember app$/) do
  expect(page).to have_content("Disorderly Conduct")
end
