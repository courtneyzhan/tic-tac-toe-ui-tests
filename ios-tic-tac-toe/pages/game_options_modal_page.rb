require File.join(File.dirname(__FILE__), "abstract_page.rb")

class GameOptionsModalPage < AbstractPage
  def initialize(driver)
    super(driver, "") # <= WIN TITLE
  end

  # page functions here ...
  def select_single_player_mode
    if (driver.find_elements(:name, "1 Player").count > 0)
      close_modal
    else
      driver.find_element(:name, "2 Players").click
    end
  end

  def select_two_player_mode
    if (driver.find_elements(:name, "2 Players").count > 0)
      close_modal
    else
      driver.find_element(:name, "1 Player").click
    end
  end

  def close_modal
    # Old - TouchAction to press coordinates. Deprecated in AppiumXCUITestDriver v7.0.0
    # close_modal_old

    # New - driver.execute_script with tap method to press coordinates
    driver.execute_script "mobile: tap", { x: 45, y: 100 }
  end

  # This doesn't work with Appium XCUITest Driver v7.0.0 and above - TouchAction was deprecated
  def close_modal_old
    Appium::TouchAction.new(driver).press(x: 45, y: 100).release.perform # close more pane
  end
end
