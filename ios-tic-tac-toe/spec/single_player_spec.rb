load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Simple Single Player Game" do
  include TestHelper

  before(:all) do
    # support only two modes: device or simulator
    execution_mode = ENV["MOBILE_EXECUTION_MODE"].to_s rescue "simulator" 
    @driver = Appium::Driver.new(appium_opts(:device => execution_mode == "device")).start_driver
    unless ENV["BUILDWISE_APPIUM_MOBILE_SEQUENTIAL"]
      # The workaround to set $driver to save screenshot, fine for parallel build
      $driver = @driver
    end
  
    puts("[DEBUG] Appium session_id: #{@driver.session_id}")
    store_appium_session_id(@driver.session_id) # save it for future debugging in TestWise, no effect to test execution

    $main_win =  driver.find_element(:name, "Tic-Tac-Toe") # save the app element
  end

  after(:all) do
    driver.quit # unless debugging?
  end

  it "Complete game by selecting next available tile" do
    game_page = GamePage.new(driver, $main_win)
    
    turn = 0
    while game_page.available_tiles.count > 0 && game_page.page_header_text.start_with?("Player")
      turn += 1
      the_next_tile = game_page.random_available_tile
      the_next_tile.click if the_next_tile
      sleep 0.05
    end

    # minimum to complete game is 3 turns if you are X (2 if you are O)
    expect(turn >= 3).to be true
  end
end
