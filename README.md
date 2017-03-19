[RongCloud](http://rongcloud.cn/) Server API SDK in Ruby
===

To view the README in Chinese, visit [README.zh-CN.md](./README.zh-CN.md)

This repository implements most essential apis for [RongCloud Server API](http://www.rongcloud.cn/docs/server.html) in Ruby programming language.

### Getting Started
1. Install the gem:

  ```sh
  $ gem install rong_cloud_server
  ```

  or, install it in Gemfile:

  ```ruby
  gem 'rong_cloud_server', '~> 0.0.2'
  ```

2. Append the following configurations in a initializer file:

  ```ruby
  RongCloud.configure do |config|
    config.app_key = "APP_KEY"
    config.app_secret = "SECRET_KEY"
    # config.host = "http://api.cn.ronghub.com"   # default: https://api.cn.ronghub.com, use http here is just convenient for debugging
  end
  ```
3. Use the instance of `RongCloud::Service` to talk to RongCloud Server:

  ```ruby
  service = RongCloud::Service.new

  # Find more usage from test files under https://github.com/Martin91/rong_cloud/tree/master/test/rong_cloud/services
  service.get_token(..., ..., ...)
  ```

### Features
1. **Lightweight**:No other third-party gems dependences;
2. **Straight and Simple**:Just wrap api connections in Ruby, no any DSL and so that you do not learn too many new syntax, no any process on response；
3. **Detailed Exceptions**:Detailed and different exceptions according to the http status code，and you can get the [detailed error code](http://www.rongcloud.cn/docs/server.html#业务返回码), officially defined by RongCloud, through calling the extended method `business_code` on a exception, please refer to [request test](https://github.com/Martin91/rong_cloud/blob/master/test/rong_cloud/request_test.rb).

### How to work with Realtime Message Forward or Online Status Subscription
Just include `RongCloud::Signature` in your codes to validate api signature and then parse params.

More infos about parameters, refer to the [official documents](http://www.rongcloud.cn/docs/server.html#服务端实时消息路由).

### How to contribute
1. Fork this repo;
2. Write your code and test;
3. Open a new Pull Request.