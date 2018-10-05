require 'json'
require 'typhoeus'
require 'cgi'

module TxTranslate
  class ParallelArray
    PROCESS_AMOUNT = 10

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

        if i % PROCESS_AMOUNT == 0
          @hydra.run
        elsif i == @content_array.size - 1
          @hydra.run
        end
      end

      @result_array
    end
  end
end
