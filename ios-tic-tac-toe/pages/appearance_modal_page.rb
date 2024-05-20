require File.join(File.dirname(__FILE__), "abstract_page.rb")

class AppearanceModalPage < AbstractPage
  def initialize(driver)
    super(driver, "") # <= WIN TITLE
  end

  # page functions here ...
  def selected_appearance
    elems = driver.find_element(:name, "Tic-Tac-Toe").find_elements(:xpath, "//XCUIElementTypeCollectionView/XCUIElementTypeCell/XCUIElementTypeButton")
    elems.each do |x|
      # puts("#{x["value"]} => #{x["label"]}")
      if x["value"] == "1"
        return x["label"]
      end
    end
    return nil
  end

  def select_appearance(appearance)
    try_for(2) { driver.find_element(:name, appearance).click }
    sleep 0.5
  end
  
end
