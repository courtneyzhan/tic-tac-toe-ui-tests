require File.join(File.dirname(__FILE__), "abstract_page.rb")

class PickSideSinglePlayerPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= WIN TITLE
  end

  # page functions here ...
  def click_continue
    driver.find_element(:id, "com.techsoldev.tictactoegame:id/ai_pick_side_continue_btn").click
    sleep 0.5
  end



  def select_o
    driver.find_element(:id, "com.techsoldev.tictactoegame:id/ai_pick_side_circle_radio").click
  end
end




