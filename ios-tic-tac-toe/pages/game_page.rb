require File.join(File.dirname(__FILE__), "abstract_page.rb")

class GamePage < AbstractPage
  attr_accessor :main_win
  attr_accessor :tiles

  def initialize(driver, the_main_win = nil)
    super(driver, "") # <= WIN TITLE
    @main_win = the_main_win
    @tiles = []
  end

  # page functions here ...

  def tile_with_index(idx)
    # the below works, but not good, too long, and not flexible
    # driver.find_element(:xpath, "//XCUIElementTypeApplication[@name='Tic-Tac-Toe']/XCUIElementTypeWindow/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeButton[#{idx}]")

    driver.find_element(:xpath, "/XCUIElementTypeApplication[@name='Tic-Tac-Toe']/XCUIElementTypeWindow//XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeButton[#{idx}]")
  end

  def all_tiles_v1
    start_time = Time.now
    elems = driver.find_elements(:xpath, "/XCUIElementTypeApplication[@name='Tic-Tac-Toe']/XCUIElementTypeWindow//XCUIElementTypeOther/XCUIElementTypeButton")
    elems.select! { |x| x.rect.height == 104 }
    # puts "matching tiles count => #{elems.size}"
    #puts("v1 cost: #{Time.now - start_time}")
    return elems
  end

  # reuse the app element to speed up
  def all_tiles_v2
    start_time = Time.now
    if @tiles.empty?
      elems = (@main_win || driver).find_elements(:xpath, "//XCUIElementTypeWindow//XCUIElementTypeOther/XCUIElementTypeButton")
      # iPhone SE2, had trouble - maybe different height
      # puts "Tile height: #{elems[0].rect.height}
      # puts "matching tiles count => #{elems.size}"
      @tiles = elems.select { |x| x.rect.height > 50 } # make sure the righ elements
      puts("v2 cost: #{Time.now - start_time}")
    end

    return @tiles
  end

  def all_tiles
    all_tiles_v2
  end

  def click_tile(tile_index)
    all_tiles[tile_index - 1].click
  end

  def is_tile_free(tile_index)
    all_tiles[tile_index - 1]["enabled"] == "true"
  end

  def click_more_options
    (@main_win || driver).find_element(:name, "more").click
    sleep 0.05
  end

  def click_restart
    (@main_win || driver).find_element(:name, "Restart").click
    sleep 0.05
  end

  def page_header_text
    (@main_win || driver).find_element(:xpath, "//XCUIElementTypeNavigationBar/XCUIElementTypeStaticText")["name"]
  end

  def available_tiles
    return all_tiles.select { |x| x["enabled"] == "true" }
  end

  # return the tile, not the index, nil if none
  def random_available_tile
    the_available_tiles = available_tiles
    return the_available_tiles.sample
  end
end
