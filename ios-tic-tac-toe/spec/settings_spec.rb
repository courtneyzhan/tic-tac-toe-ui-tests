load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Settings" do
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
  end

  before(:each) do
    game_page = GamePage.new(driver)
    #game_page.click_restart
  end

  after(:all) do
    driver.quit # unless debugging?
  end

  it "Set difficulty" do
    game_page = GamePage.new(driver)
    game_page.click_more_options
    game_options_modal_page = GameOptionsModalPage.new(driver)
    try_for(2) { driver.find_element(:name, "Difficulty").click }

    difficulty_modal_page = DifficultyModalPage.new(driver)
    expect(difficulty_modal_page.selected_difficulty).to eq("Medium")
    new_difficulty = ["Hard", "Easy"].sample
    difficulty_modal_page.select_difficulty(new_difficulty)

    game_page = GamePage.new(driver)
    game_page.click_restart

    game_page.click_more_options
    try_for(2) { driver.find_element(:name, "Difficulty").click }

    # to do verify
    difficulty_modal_page = DifficultyModalPage.new(driver)
    expect(difficulty_modal_page.selected_difficulty).to eq(new_difficulty)
    difficulty_modal_page.select_difficulty("Medium") # set it back

=begin
# NOTE
    Valid attribute names are: (
           UID,
           accessibilityContainer,
           accessible,
           enabled,
           focused,
           frame,
           hittable,
           index,
           label,
           name,
           rect,
           selected,
           type,
           value,
           visible,
           wdAccessibilityContainer,
           wdAccessible,
           wdEnabled,
           wdFocused,
           wdFrame,
           wdHittable,
           wdIndex,
           wdLabel,
           wdName,
           wdRect,
           wdSelected,
           wdType,
           wdUID,
           wdValue,
           wdVisible
           )
=end
  end

  it "Set Appearance" do
    game_page = GamePage.new(driver)
    
    elem = driver.find_element(:name, 'Tic-Tac-Toe')
    elem.save_screenshot(tmp_file("screenshot-system.png"))
    
    game_page.click_more_options
    game_options_modal_page = GameOptionsModalPage.new(driver)
    try_for(2) { driver.find_element(:name, "Appearance").click }
    
    appearance_modal_page = AppearanceModalPage.new(driver)    
    expect(appearance_modal_page.selected_appearance).to eq("System")
    appearance_modal_page.select_appearance("Dark")
    sleep 0.5
    elem = driver.find_element(:name, 'Tic-Tac-Toe')
    elem.save_screenshot(tmp_file("screenshot-dark.png"))
    # verify the two screenshot are differennt.
    expect(File.size(tmp_file("screenshot-system.png"))).not_to eq(File.size(tmp_file("screenshot-dark.png")))
        
    game_page = GamePage.new(driver)
    game_page.click_restart

    game_page.click_more_options
    try_for(2) { driver.find_element(:name, "Appearance").click }

    appearance_modal_page = AppearanceModalPage.new(driver)
    expect(appearance_modal_page.selected_appearance).to eq("Dark")
    appearance_modal_page.select_appearance("System") # set it back
  end
  
  it "Change player mode" do
    game_page = GamePage.new(driver)
    game_page.click_more_options
    game_options_modal_page = GameOptionsModalPage.new(driver)
    game_options_modal_page.select_two_player_mode

    game_page = GamePage.new(driver)
    game_page.click_more_options
    expect(driver.find_elements(:name, "1 Player").count == 0).to be true

    game_options_modal_page = GameOptionsModalPage.new(driver)
    game_options_modal_page.close_modal
  end
  
end
