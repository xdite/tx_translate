# TxTranslate 腾讯翻译

这是一个可以调用腾讯 API 的命令列工具

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tx_translate'
```

## Setting 产生设定

`tx_translate config`

* 这个命列会产生 ~/.tx_translate/settings.yml
* 密钥至 <https://console.cloud.tencent.com/cam/capi> 申请

```
---
:secret_key: ""
:secret_id: ""
:region: "ap-beijing"

```


## Usage 使用方式

* tx_translate word "This is a book" # 翻译一句话
* tx_translate sbv FILENAME # 翻译字幕
* tx_translate srt FILENAME # 翻译中英对照文档
* tx_translate md FILENAME # 翻译中英对照文档


## Other 其他说明

这个软件目前为自用，所以写得很简陋。有问题请自行修复，并拉 pull request。

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xdite/tx_translate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TxTranslate project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/tx_translate/blob/master/CODE_OF_CONDUCT.md).
