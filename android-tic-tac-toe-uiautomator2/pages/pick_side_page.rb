require File.join(File.dirname(__FILE__), "abstract_page.rb")

class PickSidePage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= WIN TITLE
  end

  # page functions here ...
  def select_cross
    driver.find_element(:id, "com.techsoldev.tictactoegame:id/pick_side_cross_radio").click # com.techsoldev.tictactoegame:id/pick_side_circle_radio
  end



  def click_continue
    driver.find_element(:id, "com.techsoldev.tictactoegame:id/pick_side_continue_btn").click
    sleep 0.5
  end
end




