load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Simple Two Player Game Ending In Draw" do
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
    driver.quit unless debugging?
  end

  it "Complete game by draw" do
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
    game_board_page.click_tile(1) # X.. ... ...
    game_board_page.click_tile(2) # XO. ... ...
    game_board_page.click_tile(3) # XOX ... ...
    game_board_page.click_tile(4) # XOX O.. ...
    game_board_page.click_tile(6) # XOX O.X ...
    game_board_page.click_tile(5) # XOX OOX ...
    game_board_page.click_tile(8) # XOX OOX .X.
    game_board_page.click_tile(9) # XOX OOX .XO
    game_board_page.click_tile(7) # XOX OOX XXO
    
    game_result_modal_page = GameResultModalPage.new(driver)    
    try_for(7, 2) { expect(game_result_modal_page.game_result_text).to eq("Match Draw !") }
  end
end
