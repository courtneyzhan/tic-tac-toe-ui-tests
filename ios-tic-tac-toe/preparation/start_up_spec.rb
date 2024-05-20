load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Install App" do
  include TestHelper

  before(:all) do
    execution_mode = ENV["MOBILE_EXECUTION_MODE"].to_s rescue "simulator" 
    @driver = Appium::Driver.new(appium_opts(:device => execution_mode == "device")).start_driver
    puts("[DEBUG] Appium session_id: #{@driver.session_id}")
    store_appium_session_id(@driver.session_id) # save it for future debugging in TestWise, no effect to test execution
  end

  after(:all) do
    driver.quit unless debugging?
  end

  it "Install and load app" do
    $main_win = driver.find_element(:name, "Tic-Tac-Toe")
    puts "Successfully found main window"
  end
end
