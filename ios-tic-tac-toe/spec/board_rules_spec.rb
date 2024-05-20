load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Basic Board Rules" do
  include TestHelper

  before(:all) do
    # support only two modes: device or simulator
    execution_mode = ENV["MOBILE_EXECUTION_MODE"].to_s rescue "simulator" 
    @driver =  Appium::Driver.new(appium_opts(:device => execution_mode == "device")).start_driver
    unless ENV["BUILDWISE_APPIUM_MOBILE_SEQUENTIAL"]
      # The workaround to set $driver to save screenshot, fine for parallel build
      $driver = @driver
    end
  
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

  it "Tile can only be selected once" do
    game_page = GamePage.new(driver)
    expect(game_page.is_tile_free(3)).to eq(true)
    game_page.click_tile(3)
    expect(game_page.is_tile_free(3)).to eq(false)
  end

  it "Board cleared when game refreshes" do
    game_page = GamePage.new(driver)
    expect(game_page.is_tile_free(1)).to eq(true)
    game_page.click_tile(1)
    expect(game_page.is_tile_free(1)).to eq(false)

    game_page.click_restart
    expect(game_page.is_tile_free(1)).to eq(true)
  end

  it "Starting player should change when game refreshes" do
    game_page = GamePage.new(driver)
    game_page.click_more_options

    game_options_modal_page = GameOptionsModalPage.new(driver)
    game_options_modal_page.select_two_player_mode

    game_page = GamePage.new(driver)
    expect(game_page.page_header_text).to eq("Player X")
    game_page.click_restart
    expect(game_page.page_header_text).to eq("Player X")

    game_page.click_tile(1)
    try_for(2) { expect(game_page.page_header_text).to eq("Player O") }
    game_page.click_restart
    # This is a failed test to research screenshots
    # expect(game_page.page_header_text).to eq("Player O")
    expect(game_page.page_header_text).to eq("Player X") # passing version
  end
end
