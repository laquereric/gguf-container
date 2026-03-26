# frozen_string_literal: true

# detect.rb — detect the current platform
#
# Returns one of: :mac, :linux, :win, :jetson_orin_nano_8g
#
# Require and call:
#   require_relative "detect"
#   platform = Detect.platform   # => :mac

module Detect
  JETSON_MODEL_FILE = "/proc/device-tree/model"
  WSL_VERSION_FILE  = "/proc/version"

  def self.platform
    return :mac if mac?
    return :jetson_orin_nano_8g if jetson?
    return :win if wsl?
    :linux
  end

  def self.mac?
    RUBY_PLATFORM.include?("darwin")
  end

  def self.jetson?
    return false unless File.exist?(JETSON_MODEL_FILE)
    File.read(JETSON_MODEL_FILE).downcase.include?("jetson")
  rescue Errno::EACCES
    false
  end

  def self.wsl?
    return false unless File.exist?(WSL_VERSION_FILE)
    File.read(WSL_VERSION_FILE).downcase.include?("microsoft")
  rescue Errno::EACCES
    false
  end

  MANAGE_SCRIPTS = {
    mac:                 "platform/mac/bin/manage.rb",
    linux:               "platform/linux/bin/manage.rb",
    win:                 "platform/win/bin/manage.rb",
    jetson_orin_nano_8g: "platform/jetson_orin_nano_8g/bin/manage.rb"
  }.freeze

  def self.manage_script(repo_root)
    rel = MANAGE_SCRIPTS[platform]
    File.join(repo_root, rel)
  end
end

# When run directly, print the detected platform
if __FILE__ == $PROGRAM_NAME
  puts Detect.platform
end
