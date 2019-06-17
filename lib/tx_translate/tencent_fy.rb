require 'httparty'
require 'json'
require 'typhoeus'
require 'cgi'

module TxTranslate
  class TencentFy
    def initialize(text)
      @encode_text = text.tr("\n", ' ')
      @escape_text = CGI.escape(@encode_text)
    end

    def region
      TxTranslate.config[:region]
    end

    def host
      "tmt.tencentcloudapi.com"
    end

    def url
      "https://#{host}"
    end

    def nonce
      rand(2323)
    end

    def secret_id
      TxTranslate.config[:secret_id]
    end

    def secret_key
      TxTranslate.config[:secret_key]
    end

    def orginal_parameters
      'Action=TextTranslate' + '&Nonce=1234' + '&ProjectId=1257710951' + "&Region=#{region}" \
        "&SecretId=#{secret_id}" + '&Source=en' + '&SourceText=' +
        @encode_text + '&Target=zh' + '&Timestamp=' + timestamp + '&Version=2018-03-21'
    end

    def encode_parameters
      'Action=TextTranslate' + '&Nonce=1234' + '&ProjectId=1257710951' + "&Region=#{region}" \
        "&SecretId=#{secret_id}" + '&Source=en' + '&SourceText=' +
        @escape_text + '&Target=zh' + '&Timestamp=' + timestamp + '&Version=2018-03-21'
    end

    def timestamp
      timestamp = Time.now.to_i.to_s
    end

    def sign_str
      "GET#{host}/?"
    end

    def data
      sign_str + orginal_parameters
    end

    def code
      digest = OpenSSL::Digest.new('sha1')
      hmac = OpenSSL::HMAC.digest(digest, secret_key, data)
      encrypt = Base64.encode64(hmac).delete("\n")
      encrypt.gsub('+', '%2B') # 处理 + 号
    end

    def request_params
      "/?#{encode_parameters}&Signature=#{code}"
    end

    def full_request_url
      url + request_params
    end

    def request_object
      HTTParty.get(url + request_params)
    end

    def json
      JSON.parse(request_object.body)
    end

    def result
      if json['Response']['Error']
        json
      else
        json['Response']['TargetText']
      end
    end
  end
end
