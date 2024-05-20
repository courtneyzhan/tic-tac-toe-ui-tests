require File.join(File.dirname(__FILE__), "abstract_page.rb")

class GameBoardPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= WIN TITLE
  end

  # page functions here ...
  def click_tile(tile_idx)
    driver.find_element(:id, "com.techsoldev.tictactoegame:id/img_#{tile_idx}").click
  end

end


