load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Sandbox" do
  include TestHelper

  before(:all) do
    @driver = Appium::Driver.new(appium_opts).start_driver
    puts("[DEBUG] Appium session_id: #{@driver.session_id}")
    store_appium_session_id(@driver.session_id) # save it for future debugging in TestWise, no effect to test execution
  end

  before(:each) do
    game_page = GamePage.new(driver)
    game_page.click_restart
  end

  after(:all) do
    driver.quit # unless debugging?
  end

  it "Sandbox" do
    game_page = GamePage.new(driver)
    # elems = driver.find_elements(:xpath, "//XCUIElementTypeApplication[@name='Tic-Tac-Toe']/XCUIElementTypeWindow//XCUIElementTypeOther/XCUIElementTypeButton")
    puts game_page.all_tiles.size
    #driver.screenshot_as(:base_64) # via core_lib
    # "//Users/courtney/tmp/screenshot.png"
    elem = driver.find_element(:name, 'Tic-Tac-Toe')
    puts elem.inspect
    elem.save_screenshot("/Users/courtney/tmp/screenshot.png")
  end
end
