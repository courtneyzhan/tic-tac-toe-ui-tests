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

  it "Complete game" do
    # XOO
    # X..
    # X..
    game_mode_selection_page = GameModeSelectionPage.new(driver)
    game_mode_selection_page.click_with_ai

    register_single_player_page = RegisterSinglePlayerPage.new(driver)
    register_single_player_page.enter_nickname("Courtney")

    register_single_player_page.click_next

    pick_side_single_player_page = PickSideSinglePlayerPage.new(driver)
    pick_side_single_player_page.click_continue

    game_board_page = GameBoardPage.new(driver)
    game_board_page.click_tile(1)
    game_board_page.click_tile(4)
    game_board_page.click_tile(7)
    
    game_result_modal_page = GameResultModalPage.new(driver)
    try_for(5, 2) { expect(game_result_modal_page.game_result_text).to eq("Player Win !") }

    # TODO find how to validate that a specific player (X/O) has won.
  end

=begin
  it "Single Player - Player X Wins Vertically" do
    # XOO
    # X..
    # X..

    game_mode_selection_page = GameModeSelectionPage.new(driver)
    game_mode_selection_page.click_with_ai

    register_single_player_page = RegisterSinglePlayerPage.new(driver)
    register_single_player_page.enter_nickname("Courtney")

    register_single_player_page.click_next

    pick_side_single_player_page = PickSideSinglePlayerPage.new(driver)
    pick_side_single_player_page.click_continue

    game_board_page = GameBoardPage.new(driver)
    game_board_page.click_tile(1)
    game_board_page.click_tile(4)
    game_board_page.click_tile(7)

    game_result_modal_page = GameResultModalPage.new(driver)    
    try_for(5, 2) { expect(game_result_modal_page.game_result_text).to eq("Player Win !") }

    # TODO find how to validate that a specific player (X/O) has won.

  end

  it "Single Player - Player X Wins Horizontally" do
    # OO.
    # ...
    # XXX

    game_mode_selection_page = GameModeSelectionPage.new(driver)
    game_mode_selection_page.click_with_ai

    register_single_player_page = RegisterSinglePlayerPage.new(driver)
    register_single_player_page.enter_nickname("Courtney")

    register_single_player_page.click_next

    pick_side_single_player_page = PickSideSinglePlayerPage.new(driver)
    pick_side_single_player_page.click_continue

    game_board_page = GameBoardPage.new(driver)
    game_board_page.click_tile(7)
    game_board_page.click_tile(8)
    game_board_page.click_tile(9)

    game_result_modal_page = GameResultModalPage.new(driver)    
    try_for(5, 2) { expect(game_result_modal_page.game_result_text).to eq("Player Win !") }

    # TODO find how to validate that a specific player (X/O) has won.

  end

  it "Single Player - AI Player O Wins \ Diagonally" do
    # O.O
    # XOX
    # XXO
    game_mode_selection_page = GameModeSelectionPage.new(driver)
    game_mode_selection_page.click_with_ai

    register_single_player_page = RegisterSinglePlayerPage.new(driver)
    register_single_player_page.enter_nickname("Courtney")

    register_single_player_page.click_next

    pick_side_single_player_page = PickSideSinglePlayerPage.new(driver)
    pick_side_single_player_page.click_continue

    game_board_page = GameBoardPage.new(driver)
    game_board_page.click_tile(4)
    game_board_page.click_tile(7)
    game_board_page.click_tile(6)
    game_board_page.click_tile(8)

    game_result_modal_page = GameResultModalPage.new(driver)    
    try_for(5, 2) { expect(game_result_modal_page.game_result_text).to eq("Robot Win !") }
    # TODO find how to validate that a specific player (X/O) has won.
  end
  
    it "Single Player - AI Player X Wins / Diagonally" do
    # O.O
    # XOX
    # XXO
    game_mode_selection_page = GameModeSelectionPage.new(driver)
    game_mode_selection_page.click_with_ai

    register_single_player_page = RegisterSinglePlayerPage.new(driver)
    register_single_player_page.enter_nickname("Courtney")

    register_single_player_page.click_next

    pick_side_single_player_page = PickSideSinglePlayerPage.new(driver)
    pick_side_single_player_page.select_o
    pick_side_single_player_page.click_continue

    game_board_page = GameBoardPage.new(driver)
    game_board_page.click_tile(9) # ... .X. ..O
    game_board_page.click_tile(8) # ... .X. XOO
    game_board_page.click_tile(6) # ..X .XO XOO

    game_result_modal_page = GameResultModalPage.new(driver)    
    try_for(5, 2) { expect(game_result_modal_page.game_result_text).to eq("Robot Win !") }
    # TODO find how to validate that a specific player (X/O) has won.
  end

  it "Single Player - Draw" do
    game_mode_selection_page = GameModeSelectionPage.new(driver)
    game_mode_selection_page.click_with_ai

    register_single_player_page = RegisterSinglePlayerPage.new(driver)
    register_single_player_page.enter_nickname("Courtney")

    register_single_player_page.click_next

    pick_side_single_player_page = PickSideSinglePlayerPage.new(driver)
    pick_side_single_player_page.click_continue

    game_board_page = GameBoardPage.new(driver)
    game_board_page.click_tile(1) # XO. ... ...
    game_board_page.click_tile(5) # XOO .X. ...
    game_board_page.click_tile(6) # XOO OXX ...
    game_board_page.click_tile(7) # XOO OXX X.O
    game_board_page.click_tile(8) # XOO OXX XXO

    game_result_modal_page = GameResultModalPage.new(driver)    
    try_for(5, 2) { expect(game_result_modal_page.game_result_text).to eq("Match Draw !") }
  end
=end
end
