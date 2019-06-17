require 'json'
require 'typhoeus'
require 'cgi'

module TxTranslate
  class ParallelArray


    def process_amount
      TxTranslate.config[:process_amount] || 5
    end

    # 平行处理
    def initialize(array)
      @content_array = array
      @result_array = []
      @hydra = Typhoeus::Hydra.new
    end

    def parallel_process

      @content_array.each_with_index do |item, i|
        text = ''
        request = Typhoeus::Request.new(TxTranslate::TencentFy.new(item).full_request_url.to_s, followlocation: true)

        request.on_complete do |response|
          json = JSON.parse(response.body)

          text = if json['Response']['Error']
                   TxTranslate::TencentFy.new(item).full_request_url
                 else
                   json['Response']['TargetText']
                 end
          puts text
          @result_array[i] = text
        end

        @hydra.queue(request)
        sleep(1.0/process_amount)
        @hydra.run
      end

      @result_array
    end
  end
end
