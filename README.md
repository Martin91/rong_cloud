[RongCloud](http://rongcloud.cn/) Server API SDK in Ruby
===
[![Build Status](https://travis-ci.org/Martin91/rong_cloud.svg?branch=master)](https://travis-ci.org/Martin91/rong_cloud)
[![Coverage Status](https://coveralls.io/repos/github/Martin91/rong_cloud/badge.svg?branch=master)](https://coveralls.io/github/Martin91/rong_cloud?branch=master)
[![Code Climate](https://codeclimate.com/github/Martin91/rong_cloud/badges/gpa.svg)](https://codeclimate.com/github/Martin91/rong_cloud)

This repository implements most essential apis for [RongCloud Server API](http://www.rongcloud.cn/docs/server.html) in Ruby programming language.

### Getting Started
1. Install the gem:

  ```sh
  $ gem install rong_cloud_server
  ```

  or, install it in Gemfile:

  ```ruby
  gem 'rong_cloud_server'
  ```

2. Append the following configurations in a initializer file:

  ```ruby
  require 'rong_cloud'

  RongCloud.configure do |config|
    config.app_key = "APP_KEY"
    config.app_secret = "SECRET_KEY"
    # config.host = "http://api.cn.ronghub.com"   # default: https://api.cn.ronghub.com, use http here is just convenient for debugging
    # config.timeout = 10 # set open timeout and read timeout in seconds for http request, default is 2 seconds
    # config.debug_mode = true # if need to log request and response details, the log file is at "log/rong_cloud_debug.log", default is `false`
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

### Run tests
```sh
ruby -Ilib -Itest -e 'ARGV.each { |f| require f }' ./test/**/*_test.rb
```

### How to contribute
1. Fork this repo;
2. Write your code and test;
3. Open a new Pull Request.

### TODO
1. Logger support
