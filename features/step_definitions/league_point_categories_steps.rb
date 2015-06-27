When(/^I go to that league's scoring page$/) do
  visit "/leagues/#{@league.id}/scoring"
end

Then(/^I should see the BadCeleb point categories$/) do
  @league_template.point_categories.each do |point_category|
    expect(page).to have_content(point_category.group)
    expect(page).to have_content(point_category.title)
  end
end
