require 'watir'

Before do |scenario|
  DataMagic.load_for_scenario(scenario)
  @browser = Watir::Browser.new $browser_type
end


After do
  @browser.close
end

After do |scenario|
  SCREENSHOTS_DIRECTORY = "html-report"
  if scenario.failed?
    #save screenshots to features/test_results/Screenshots directory, name is scenario name + timestamp
    screenshot = "#{Time.now.strftime("%m-%d_%H-%M-%S")}_#{scenario.name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, '')}.png"
    @browser.driver.save_screenshot(File.join(SCREENSHOTS_DIRECTORY, screenshot))
    embed(File.join(SCREENSHOTS_DIRECTORY, screenshot), "image/png", "SCREENSHOT")
  end
end