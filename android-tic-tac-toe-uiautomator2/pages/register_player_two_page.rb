require File.join(File.dirname(__FILE__), "abstract_page.rb")

class RegisterPlayerTwoPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= WIN TITLE
  end

  # page functions here ...
  def enter_nickname(nickname)
    driver.find_element(:id, "com.techsoldev.tictactoegame:id/player_two_name_edttxt").send_keys(nickname)
  end



  def click_next
    driver.find_element(:id, "com.techsoldev.tictactoegame:id/player_two_btn").click
    sleep 0.5
  end
end




