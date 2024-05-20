# require 'rubygems'
gem "appium_lib"

require "appium_lib"
require "rspec"

# include utility functions such as 'page_text', 'try_for', 'fail_safe', ..., etc.
require "#{File.dirname(__FILE__)}/agileway_utils.rb"

# this loads defined page objects under pages folder
require "#{File.dirname(__FILE__)}/pages/abstract_page.rb"
Dir["#{File.dirname(__FILE__)}/pages/*_page.rb"].each { |file| load file }
Dir["#{File.dirname(__FILE__)}/pages/*_window.rb"].each { |file| load file }
Dir["#{File.dirname(__FILE__)}/pages/*_dialog.rb"].each { |file| load file }
Dir["#{File.dirname(__FILE__)}/pages/*_view.rb"].each { |file| load file }


# This is the helper for your tests, every test file will include all the operation
# defined here.
module TestHelper
  include AgilewayUtils
  if defined?(TestWiseRuntimeSupport)
    include TestWiseRuntimeSupport
  end

  def driver
    @driver
  end
  
  def store_appium_session_id(session_id)
    return # TODO store appium Id
  end 

  def app_id_zip
    # '/Users/courtney/UICatalog.app.zip'
    File.join(File.dirname(__FILE__), "..", "..", "sample-apps", "tic-tac-toe.app.zip")
  end
  
  def app_id_ipa
    # '/Users/courtney/UICatalog.app.zip'
    File.join(File.dirname(__FILE__), "..", "..", "sample-apps", "tic-tac-toe.ipa")
  end
  
  def app_file_path(opts = {})
    if opts[:app_type] == "ipa"
      return app_id_ipa
    else
      return app_id_zip
    end  
  end
  
  def appium_opts(opts = {})
    if opts[:device]
      return appium_xcuitest_opts_device(opts[:reinstall_app])
    else          
      return appium_xcuitest_opts_simulator(opts[:reinstall_app])
    end
  end

  def appium_xcuitest_opts_simulator(should_reinstall_app = false)
    opts = {
      caps: {
        platformName: 'ios',
        automationName: 'xcuitest',
        platformVersion: '17.2',  # change to match your Xcode
        deviceName: 'iPhone 15',  # change here if necessary
        app: app_file_path(:app_type => "zip"),
        noReset: !should_reinstall_app # do not re-install APP, should be faster to start tests. Pre req: Agent is installed, app is installed. That can be done in app deployment test before running whole suite
      },
        appium_lib: {
          server_url: "http://127.0.0.1:4723",
          wait: 0.1,
        },
    }
  end
  

  def appium_xcuitest_opts_device(should_reinstall_app = false)
    opts = {
      caps: {
        platformName: 'ios',
        automationName: 'xcuitest',
        #   Xindi iPhone SE2
        # platformVersion: '17.2',  # change to match your Xcode
        # deviceName: "iPhone",  # change here if necessary
        # udid: "00008030-001971C83E6B802E",

        #   Zhimin iPhone SE3
        platformVersion: '17.3',  # change to match your Xcode
        deviceName: "Zhimin’s iPhone SE3",  # change here if necessary
        udid: "00008110-000950C91488401E",
        xcodeSigningId: "CAJ4TQHVG2",
        xcodeOrgId: "489Z00LARQ",
        app: app_file_path(:app_type => "ipa")
      },
        appium_lib: {
          server_url: "http://127.0.0.1:4723",
          wait: 0.1,
        },
    }
  end
  
  
  # TODO:  unverified, run without error, but haven't found examples to use it
  #  sample session id: "cfb372b9-fb3c-42da-8f16-cea146eb177e"
  # ref: https://github.com/appium/ruby_lib_core/blob/master/lib/appium_lib_core/driver.rb
  def attach_appium_session(session_id = nil)
    the_last_session_id = retrieve_last_appium_session_id rescue nil 
    the_session_id = session_id || the_last_session_id
    new_driver = Appium::Core::Driver.attach_to(the_session_id,
                                                url: "http://127.0.0.1:4723",
                                                automation_name: appium_opts[:caps][:automationName] || "xcuitest",
                                                platform_name: appium_opts[:caps][:platformName] || "ios")
  end
  
  
  def debugging?
    if ENV["RUN_IN_TESTWISE"].to_s == "true" && ENV["TESTWISE_RUNNING_AS"] == "test_case"
      return true
    end
    return $TESTWISE_DEBUGGING && $TESTWISE_RUNNING_AS == "test_case"
  end
  
  # quick to refer the test data file under 'testdata' folder
  def test_data_file(relative_path)
    the_file = File.expand_path File.join(File.dirname(__FILE__), "testdata", relative_path)
    the_file.gsub!("/", "\\") if RUBY_PLATFORM =~ /mingw/
    return the_file
  end

  # quick to refer tmp file under 'tmp' folder
  def tmp_dir(sub_dir_name, opts = {})
    the_dir = File.expand_path File.join(File.dirname(__FILE__), "tmp", sub_dir_name)
    the_dir.gsub!("/", "\\") if RUBY_PLATFORM =~ /mingw/
    unless opts[:do_not_create]
      FileUtils.mkdir_p(the_dir) unless Dir.exist?(the_dir)
    end
    return the_dir
  end
	
  def tmp_file(file_name, opts = {})
    File.expand_path File.join(File.dirname(__FILE__), "tmp", file_name)
  end
  
  # prevent extra long string generated test scripts that blocks execution when running in
  # TestWise or BuildWise Agent
  def safe_print(str)
    return if str.nil? || str.empty?
    if (str.size < 250)
      puts(str)
      return
    end

    if ENV["RUN_IN_TESTWISE"].to_s == "true" && ENV["RUN_IN_BUILDWISE_AGENT"].to_s == "true"
      puts(str[0..200])
    end
  end
  
  # a convenient method to use main_window, if @main_window is set 
  def main_window
    @main_window
  end
  
  # a convenient method to use main_window, extract function refactoring support use this
  #  driver.find_element(...), after extraction => win.find_element
  # this way, test execution can still run faster in debugging mode (attach session)
  def win
    @main_window
  end
  
end

