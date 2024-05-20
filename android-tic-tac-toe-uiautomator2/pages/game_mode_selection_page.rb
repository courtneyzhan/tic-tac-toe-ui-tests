require File.join(File.dirname(__FILE__), "abstract_page.rb")

class GameModeSelectionPage < AbstractPage
  def initialize(driver)
    super(driver, "") # <= WIN TITLE
  end

  # page functions here ...
  def click_with_ai
    driver.find_element(:id, "com.techsoldev.tictactoegame:id/btn_choice1_offline_menu").click
    sleep 0.75
  end

  def click_with_friend
    driver.find_element(:id, "com.techsoldev.tictactoegame:id/btn_choice2_offline_menu").click
    sleep 0.75
  end
end
