# History/Changelog

### 02-Jan-2024

Add additional tests:
* Game Difficulty (Randomly chooses difficulty)
* Dark mode
* Added test for vertical win and / win
  * TODO add test for horizontal win and \ win
  
Refactoring
* More readable tests for single player spec -> not index of next available tile, select random elem out of all available types and click it

### 03-Jan-2024


TIPS for using XPath
Limiting scope of XPaths to application, and not //
Mobile apps work differently to a webbrowser's test. A web browser is limited to what is active in the browser, but mobile platforms handle all open apps.
Most of the time, quite a few applications are running at once.

It's recommended to use some way to identify the current app (XCUIElementTypeApplication) and use that as the first XPath elem (/XCUIElementTypeApplication)
Then, build further queries on top of that.

This will speed up the execution of your test significantly.

For refactoring your project, we recommend using a global variable within the page to store the application part of XPath. 
If this global variable is not available, it is fine to default to the (slower) non-application path.

elems = ($main_win || driver).find_elements(:xpath, "//XCUIElementTypeWindow//XCUIElementTypeOther/XCUIElementTypeButton")