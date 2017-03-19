require 'minitest/autorun'
require 'byebug'
require 'rong_cloud'
require 'simplecov'
require 'coveralls'

SimpleCov.start do
  add_filter "/test/"
end

Coveralls.wear!

def rong_cloud_configure_with_settings
  RongCloud.configure do |config|
    config.app_key = ENV["RONGCLOUD_APP_KEY"]
    config.app_secret = ENV["RONGCLOUD_APP_SECRET"]
    config.host = ENV["RONGCLOUD_API_HOST"] || "https://api.cn.ronghub.com"
  end
end