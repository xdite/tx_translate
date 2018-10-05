module TxTranslate
  class MdProcess
    include Singleton

    def self.run(filename)
      file = File.open(filename, "r")
      contents = file.read
      new_contents = ""


      old_content_array = contents.split("\n\n")


      new_content_array = ParallelArray.new(old_content_array).parallel_process

      old_content_array.each_with_index do |item,i|
        new_contents += old_content_array[i] + "\n\n" + new_content_array[i] + "\n\n"
      end

      file = File.open("#{ARGV[1]}_new.md", "w") { |f| f.write(new_contents) }
    end
  end
end
