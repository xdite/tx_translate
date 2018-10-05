module TxTranslate
  class SbvProcess
    include Singleton

    def self.run(filename)
      file = File.open(filename, 'r')
      contents = file.read + "\n\n"

      subbed = ''

      original_content_array = []
      timeline_content_array = []
      context_content_array = []

      # 先切段
      contents.gsub(/(\d:\d{2}:\d{2}.\d{3}),(\d:\d{2}:\d{2}\.\d{3})\n((?:^.*$\n)*?)\n/).with_index do |m, i|
        original_content_array[i] = m # 旧内容

        timeline_content_array[i] = "#{Regexp.last_match(1)},#{Regexp.last_match(2)}"
        context_content_array[i] = Regexp.last_match(3).to_s
      end

      context_content_array = TxTranslate::ParallelArray.new(context_content_array).parallel_process

      original_content_array.each_with_index do |_item, i|
        subbed += timeline_content_array[i] + "\n" + context_content_array[i] + "\n\n"
      end

      file = File.open("#{ARGV[1]}_new.sbv", 'w') { |f| f.write(subbed) }
    end

  end
end
