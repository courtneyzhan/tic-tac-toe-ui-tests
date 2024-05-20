load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Simple Two Player Game Ending In Draw" do
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
    
    game_page = GamePage.new(driver)
    game_page.click_more_options

    game_options_modal_page = GameOptionsModalPage.new(driver)
    game_options_modal_page.select_two_player_mode

  end

  after(:all) do
    driver.quit # unless debugging?
  end

  before(:each) do
    game_page = GamePage.new(driver)
    game_page.click_restart
  end
  
  # Game Tile Index
  #
  # 123
  # 456
  # 789

  it "Complete game by draw" do
    game_page = GamePage.new(driver, $main_win)
    game_page.click_tile(1) # X.. ... ...
    game_page.click_tile(2) # XO. ... ...
    game_page.click_tile(3) # XOX ... ...
    game_page.click_tile(4) # XOX O.. ...
    game_page.click_tile(6) # XOX O.X ...
    game_page.click_tile(5) # XOX OOX ...
    game_page.click_tile(8) # XOX OOX .X.
    game_page.click_tile(9) # XOX OOX .XO
    game_page.click_tile(7) # XOX OOX XXO

    expect(game_page.page_header_text).to eq("Draw!")
  end
end
