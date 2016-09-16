require 'minitest/autorun'
require 'byebug'
require 'rong_cloud'
require 'yaml'

$settings = YAML.load_file("./config.yml")

def rong_cloud_configure_with_settings
  RongCloud.configure do |config|
    $settings.each do |setting, value|
      config.send("#{setting}=", value)
    end
  end
end