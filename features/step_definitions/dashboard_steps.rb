Given(/^the data importing process runs$/) do
  PronosticosDashboard::DB.setup
  PronosticosDashboard::Models
  DataMapper.auto_migrate!

  DataMapper::Model.descendants.entries.each do |table|
    file = File.expand_path("spec/fixtures/#{table}.yml")
    YAML.load_file(file).each do |fixture|
      table.create(fixture)
    end
  end
end

Given(/^I go to the dashboard$/) do
  visit '/'
  expect(page).to have_content('Dashboard')
end

Given(/^the current date is "(.*?)"$/) do |current_date|

end

Then(/^I should see the Days Missing Data Report$/) do
  expect(page).to have_content('152300500	2014-07-03 Missed')
  expect(page).to have_content('152300200	2014-07-04 Missed')
  expect(page).to have_content('152300500	2014-07-04 Missed')
  expect(page).to have_content('152300200	2014-07-05 Missed')
  expect(page).to have_content('152300500	2014-07-05 Missed')
  expect(page).to have_content('152300200	2014-07-06 Missed')
  expect(page).to have_content('152300500	2014-07-06 Missed')
end
