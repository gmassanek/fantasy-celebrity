When(/^I go to that league's positions page$/) do
  visit "/leagues/#{@league.id}/positions"
end

Then(/^I should see the BadCeleb positions$/) do
  @league_template.positions.each do |position|
    expect(page).to have_content(position.title)
    expect(page).to have_content(position.suggested_count)
  end
end
