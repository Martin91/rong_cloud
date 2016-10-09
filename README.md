融云 Server SDK
===

此 gem 实现了[融云 Server API](http://www.rongcloud.cn/docs/server.html)的大部分接口的 Ruby 实现。

### Getting Started
1. 安装此 gem；
2. 在项目中添加配置：

  ```ruby
  RongCloud.configure do |config|
    config.app_key = "APP_KEY"
    config.secret_key = "SECRET_KEY"
    config.host = "http://api.cn.ronghub.com"   # default: https://api.cn.ronghub.com, use http is convenient for debugging
  end
  ```
3. 通过 service 对象使用：

  ```ruby
  service = RongCloud::Service.new

  # 更多方法，请查看测试用例 https://github.com/Martin91/rong_cloud/tree/master/test/rong_cloud/services
  service.get_token(..., ..., ...)
  ```

### 特点
1. **轻量**：无其他依赖；
2. **简洁**：不过分封装，仅做必要的请求实现，使用方自行处理响应的 JSON 解析后的 Hash 对象，各字段释义请自行查阅融云文档；
3. **丰富的异常类型**：针对不同的 HTTP 状态码，抛出相对应的异常类型，同时可以通过异常对象的 `business_code` 方法获取错误业务码，可以参考[request test 的代码](https://github.com/Martin91/rong_cloud/blob/master/test/rong_cloud/request_test.rb)。

### TODOs
1. 私聊与系统模板消息；
2. 聊天室其他服务以及高级接口实现；
3. 实时消息路由；
4. 消息历史记录；
5. 在线状态订阅。

### How to contribute
1. Fork this repo;
2. Write your code and test;
3. Open a new Pull Request.