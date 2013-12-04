Then(/^(?:|I )should see a navigation bar$/) do
  expect(page).to have_css('div.navbar')
end

And(/^(?:|I )should see navigation links$/) do
  expect(page).to have_css('ul.nav')
end