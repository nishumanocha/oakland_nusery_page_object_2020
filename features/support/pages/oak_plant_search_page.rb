class OakPlantSearchPage < OakWishListPage
  include PageObject

  page_url 'http://plants.oaklandnursery.com/12130001'
  # page_url $app_url

  text_field(:search_plant_edit_box, id: 'NetPS-KeywordInput')
  button(:submit, id: 'NetPSSubmit')
  links(:plant_names, class: /NetPS-ResultsP(2|)Link$/)
  checkbox(:choose_first_result, id: 'CheckmP1')
  link(:select_wish_list, text: 'view my wish list')
  div(:wish_list_header, id: 'NetPS-mPTitle')
  div(:plant_details, class: 'NetPS-ResultsDataSub')

  def search_plant plant_name
    # search_plant_edit_box_element.set plant_name
    self.search_plant_edit_box = plant_name
    submit_element.click
  end

  def get_all_plant_name
    all_result = [] #----------#-----------#Instead of .map we can use this
    plant_names_elements.each do |each_value|
      all_result << each_value.text
      p each_value
    end
    all_result
    #plant_names_elements.maps(&:text)
  end

  def verify_plant_search_is_correct plant_name
    get_all_plant_name.each do |each_name|
      p "verifying the plant #{each_name} has correct value #{plant_name}"
      fail "Plant Name #{each_name} is not related to #{plant_name}" unless each_name.include? plant_name
    end
  end

  def verify_no_of_plant_search_results max_result
    fail "No of results are more than 10" unless plant_names_elements.count > max_result
  end

  # # 1Case
  # search_plant 'Rose'
  # verify_plant_search_is_correct 'Rose'
  # verify_no_of_plant_search_results
  #
  def add_plant_to_wishlist
    #@browser.checkbox(id: 'CheckmP1').set
    # choose_first_result_element.when_present(60). set
    # fail "check box is not selected" unless choose_first_result_element.checked?
    unless choose_first_result_element.checked?
      choose_first_result_element.when_present(60).set #-------------------did not get this
    end
    select_wish_list_element.click
    fail "You are not on wishlist page" unless wish_list_header_element.text.eql? 'My wishlist'
  end

  def verify_wishlist_has_plant first_plant_name_from_search_page
    first_plant_name_from_wishlist_page = get_all_plant_name.first
    fail "Wishlist doesnt has the correct plant" unless first_plant_name_from_search_page == first_plant_name_from_wishlist_page
  end

  def update_wishlist_quantity new_quantity
    @browser.text_field(id: 'QtymP1').set new_quantity
    #@browser.link(text: 'update my wish list').click
  end

  def verify_wishlist_quantity_has_updated exp_quantity
    new_quantity = @browser.text_field(id: 'QtymP1').value
    fail "#{exp_quantity} is not same as #{new_quantity}" unless exp_quantity.eql? new_quantity.to_i
  end

  def empty_wishlist
    @browser.checkbox(id: 'CheckmP1').click if @browser.checkbox(id: 'CheckmP1').checked?
    @browser.link(text: 'Update My Wish List').click
    sleep 2
  end

  def verify_wishlist_is_empty
    fail "Wish list empty message is not shown - #{@browser.div(class: 'NetPS-MessageBlock').strong.text}"
  end

  def get_plant_info
    plant_info_hash = {}
    plant_details_element.text.split("\n").each do |plant_detail_info|
      plant_info_hash[plant_detail_info.split(": ")[0]] = plant_detail_info.split(": ")[1].strip
    end
    p plant_info_hash
  end

end