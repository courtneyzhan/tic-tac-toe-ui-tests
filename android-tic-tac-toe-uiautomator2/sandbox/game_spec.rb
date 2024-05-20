load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Simple Single Player Game" do
  include TestHelper

  before(:all) do
    @driver = Appium::Driver.new(appium_opts).start_driver
    sleep 2 # load game
  end

  after(:each) do
    game_result_modal_page = GameResultModalPage.new(driver)    
    game_result_modal_page.click_quit
    sleep 2 # wait for loading back to home page
  end

  after(:all) do
    driver.quit # unless debugging?
  end

  it "Text shows current player's turn" do
game_mode_selection_page = GameModeSelectionPage.new(driver)
    game_mode_selection_page.click_with_friend

    register_player_one_page = RegisterPlayerOnePage.new(driver)
    register_player_one_page.enter_nickname("Sully")
    register_player_one_page.click_next

    register_player_two_page = RegisterPlayerTwoPage.new(driver)
    register_player_two_page.enter_nickname("Randall")
    register_player_two_page.click_next

    pick_side_page = PickSidePage.new(driver)
    pick_side_page.select_cross
    pick_side_page.click_continue

    game_board_page = GameBoardPage.new(driver)
  end

end
