module TxTranslate
  class SrtProcess
    include Singleton

    def self.run(filename)
      file = File.open(filename, 'r')
      basename = File.basename(filename, "srt")

      contents = file.read + "\n\n"
      contents.gsub!("\r\n", "\n") # 处理 CRLF 转 LF 问题

      puts contents

      subbed = ''

      original_content_array = []
      timeline_content_array = []
      context_content_array = []

      # 先切段
      contents.gsub(/(.+)\n(\d{2}:\d{2}:\d{2},\d{3} --> \d{2}:\d{2}:\d{2},\d{3})\n((?:^.*$\n)*?)\n/).with_index do |m, i|
        original_content_array[i] = m # 旧内容

        timeline_content_array[i] = "#{Regexp.last_match(2)}"
        context_content_array[i] = Regexp.last_match(3).to_s
      end

      puts original_content_array.size

      context_content_array = TxTranslate::ParallelArray.new(context_content_array).parallel_process

      original_content_array.each_with_index do |_item, i|
        subbed += "#{i}\n" + timeline_content_array[i] + "\n" + context_content_array[i] + "\n\n"
      end

      file = File.open("#{basename}zh-si.srt", 'w') { |f| f.write(subbed) }
    end

  end
end
