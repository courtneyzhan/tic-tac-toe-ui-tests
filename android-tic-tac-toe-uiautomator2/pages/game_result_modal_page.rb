require File.join(File.dirname(__FILE__), "abstract_page.rb")

class GameResultModalPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= WIN TITLE
  end

  # page functions here ...
  def game_result_text
    driver.find_element(:class_name, "android.widget.TextView").text
  end

  def click_quit
    if game_result_text == "Player Win !"
      click_quit_on_player_win
    else
      click_quit_on_robot_win_or_draw
      end
    end

  def click_quit_on_player_win
    driver.find_element(:id, "com.techsoldev.tictactoegame:id/offline_game_quit_btn").click
  end
  
    def click_quit_on_robot_win_or_draw
    driver.find_element(:id, "com.techsoldev.tictactoegame:id/offline_game_draw_quit_btn").click
  end


  def click_continue
    driver.find_element(:id, "com.techsoldev.tictactoegame:id/offline_game_continue_btn").click
  end
end






