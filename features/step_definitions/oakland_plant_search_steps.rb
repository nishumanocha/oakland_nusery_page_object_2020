Given(/^user is on plant search page$/) do
  visit OakPlantSearchPage
end

When(/^user search for the plant (.+)$/) do |plant_name|
  on(OakPlantSearchPage).search_plant plant_name
end

Then(/^user should see the results related for (.+)$/) do |plant_name|
  on(OakPlantSearchPage).verify_plant_search_is_correct plant_name
end

And(/^verify the search results count is not more than (\d+)$/) do |max_result|
  on(OakPlantSearchPage).verify_no_of_plant_search_results max_result
end

And(/^user add the first result to the wish list$/) do
  @first_plant_name = (OakPlantSearchPage).get_all_plant_names.first
  on(OakPlantSearchPage).add_plant_to_wishlist
end

Then(/^verify the added plant is showing under wishlist page$/) do
  on(OakPlantSearchPage).verify_wishlist_has_plant @first_plant_name
end

And(/^user modifies the quantity of the wish list item$/) do
  on(OakWishListPage).update_wishlist_quantity 3
end

Then(/^verify user can see the updated quantity$/) do
  on(OakWishListPage).verify_wishlist_quantity_has_updated 2
end

When(/^user adds the plant(.*) to the wish list$/) do |plant_name|
  on(OakPlantSearchPage).search_plant plant_name
  @first_plant_name = on(OakPlantSearchPage).get_all_plant_names.first
  on(OakPlantSearchPage).add_plant_to_wishlist
  on(OakPlantSearchPage).verify_wishlist_has_plant @first_plant_name
end

And(/^user empty the wishlist$/) do
  on(OakWishListPage).empty_wishlist
end

Then(/^user should see the confirmation message "([^"]*)"$/) do |message|
  on(OakErrorPage).verify_wishlist_empty_message_displayed message
end

And(/^get the details of the plant$/) do
  p on(OakPlantSearchPage).get_plant_info
end

And(/^verify the details of the plant$/) do |table|
  # table is a table.hashes.keys # => [:plant_details, :plant_values]
  actual_plant_details = on(OakPlantSearchPage).get_plant_info
  expected_plant_details = {}
  table.hashes.each do |plant|
    expected_plant_details[plant['plant_details']] = plant['plant_values']
  end
  p expected_plant_details
  p actual_plant_details
  # fail "#{expected_plant_details} is not same as #{actual_plant_details}" unless expected_plant_details == actual_plant_details
  expect(expected_plant_details.sort).should eql? actual_plant_details.sort
end

And(/^verify the header details of the plant$/) do |table|
  # table is a table.hashes.keys # => [:plant_details]
  actual_plant_details = on(OakPlantSearchPage).get_plant_info
  expected_plant_details = {}
  table.hashes.each do |plant|
    header_found = false
    actual_plant_details.each_key do |each_header|
      if each_header[key].include? plant['plant value']
        header_found = true
        break
      end
    end
    if header_found != true
      fail "The header #{plant['plant_details']} Not Found"
    else
      break
    end
  end
end

Then(/^user can modified the quantity in the wish list$/) do
  # on(OakPlantSearchPage).search_plant 'Rose'
  # @first_plant_name = (OakPlantSearchPage).get_all_plant_names.first
  # on(OakPlantSearchPage).add_plant_to_wishlist
  #OR
  on(OakPlantSearchPage) do |page|
    page.search_plant 'Rose'
    @first_plant_name = page.get_all_plant_names.first
    page.add_plant_to_wishlist

  end
  # on(OakWishListPage).update_wishlist_quantity 2
  # on(OakWishListPage).verify_wishlist_quantity_has_updated 2
  # OR
  on(OakWishListPage) do |page|
    page.update_wishlist_quantity 3
    page.verify_wishlist_quantity_has_updated 3
  end
  #OR
  plant_name = 'Rose'
  step "user search for the plant #{plant_name}"
  step 'user add the first result to the wish list'
  step 'user modifies the quantity of the wish list item'
  step 'user can see the updated quantity'

  #OR

  steps %Q{
   When user search for the plant Rose
    And user add the first result to the wish list
    And user modifies the quantity of the wish list item
    Then verify user can see the updated quantity
}
end

When(/^user verifies data can be read from yml file$/) do
  # file_path = 'features/support/test data/test_data.yml'
  # test_data = YAML.load_file file_path
  p $test_data['language_name']
  p $test_data['chase']['id']
  p 'change the data'
  $test_data['chase'][id] = 500
  p $test_data['chase'][id]

  file.open($file_path, 'w') { |f|
    $test_data['chase']['id'] = 1000
    f.write($test_data.to_yaml)
  }
  p $test_data['chase']['id']
  p 'done'
end

# test_data['chase']['id']
# test_data.fetch('language_name')
# test_data['chase']['id'] = 400
# test_data['chase']['id']
# Moved the above code to env.rb for reloading the file automatically
And(/^verify the details of the (.*) are correct$/) do |plant_name|
  p $test_data[plant_name]['plant_name']


  # table is a table.hashes.keys # => [:plant_details, :plant_values]
  actual_plant_details = on(OakPlantSearchPage).get_plant_info
  expected_plant_details = $test_data[plant_name]

  expect(expected_plant_details.sort).should eql? actual_plant_details.sort
end
  p 'done'